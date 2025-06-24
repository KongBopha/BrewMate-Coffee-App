import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:brewmate_coffee_app/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItems> _orders = [];
  List<OrderItems> get orders => List.unmodifiable(_orders);

  double _deliveryFee = 0.0;
  double get deliveryFee => _deliveryFee;

  String _userAddress = '';
  String get userAddress => _userAddress;

  String _userNote = '';
  String get userNote => _userNote;

  // ──────────────────────────────
  // SETTERS FOR ADDRESS AND NOTE
  // ──────────────────────────────

  void setAddress(String address) {
    _userAddress = address;
    notifyListeners();
  }

  void setNote(String note) {
    _userNote = note;
    notifyListeners();
  }
  void setPickupAddress() {
  _userAddress = "BrewMate Coffee Shop, Street 123, Phnom Penh, Cambodia";
  _deliveryFee = 0.0;
  notifyListeners();
}

  /// Convert latitude & longitude to readable address and update state
  Future<void> setAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        _userAddress =
            "${place.name ?? ''}, ${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
      } else {
        _userAddress = "Unknown location";
      }
    } catch (e) {
      _userAddress = "Error fetching address";
      if (kDebugMode) print("Geocoding error: $e");
    }

    notifyListeners();
  }

  // ──────────────────────────────
  // DELIVERY FEE CALCULATION
  // ──────────────────────────────

  Future<void> calculateDeliveryFeeFromCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      double userLat = position.latitude;
      double userLng = position.longitude;

      // Static shop coordinates
      const double shopLat = 11.562108;
      const double shopLng = 104.888535;

      double distanceInMeters = Geolocator.distanceBetween(
        shopLat, shopLng, userLat, userLng,
      );

      double distanceInKm = distanceInMeters / 1000;

      // Dynamic fee based on distance
      if (distanceInKm <= 2.5) {
        _deliveryFee = 0.5;
      } else if (distanceInKm <= 5) {
        _deliveryFee = 0.75;
      } else {
        _deliveryFee = 1.0;
      }
    } catch (e) {
      _deliveryFee = 0.0;
      if (kDebugMode) print("Error getting location: $e");
    }

    notifyListeners();
  }

  // ──────────────────────────────
  // ORDER MANAGEMENT
  // ──────────────────────────────

  /// Submit order and clear user's cart
  Future<void> placeOrder(List<CartItem> items, double totalPrice) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final orderData = {
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'status': 'pending',
      'note': _userNote,
      'address': _userAddress,
      'deliveryFee': _deliveryFee,
      'createdAt': DateTime.now().toIso8601String(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .add(orderData);

    // Clear cart items
    final cartCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cartItems');

    final snapshot = await cartCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    notifyListeners();
  }

  /// Load user order history from Firestore
  Future<void> fetchOrders() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .get();

    _orders.clear();
    for (var doc in snapshot.docs) {
      _orders.add(OrderItems.fromFirestore(doc));
    }

    notifyListeners();
  }
}
