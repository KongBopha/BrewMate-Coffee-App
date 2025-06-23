import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:brewmate_coffee_app/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItems> _orders = [];
  List<OrderItems> get orders => List.unmodifiable(_orders);
  double _deliveryFee = 0.0;
  double get deliveryFee => _deliveryFee;

  // Place an order
  Future<void> placeOrder(List<CartItem> items, double totalPrice) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final orderData = {
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'status': 'pending',
      'createdAt': DateTime.now().toIso8601String(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .add(orderData);

    // Clear cart after placing the order
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

  // Fetch order history
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

  // deliverycalculation
  Future<void> calculateDeliveryFeeFromCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    double userLat = position.latitude;
    double userLng = position.longitude;

    const double shopLat = 11.562108;
    const double shopLng = 104.888535;

    double distanceInMeters = Geolocator.distanceBetween(
      shopLat, shopLng, userLat, userLng,
    );

    double distanceInKm = distanceInMeters / 1000;

    if (distanceInKm <= 3) {
      _deliveryFee = 1.5;
    } else if (distanceInKm <= 5) {
      _deliveryFee = 2.0;
    } else {
      _deliveryFee = 3.0;
    }
  } catch (e) {
    _deliveryFee = 0.0;
    if (kDebugMode) {
      print("Error getting location: $e");
    }
  }

  notifyListeners();
}

}
