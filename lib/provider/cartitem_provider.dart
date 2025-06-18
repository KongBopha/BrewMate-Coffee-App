import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartItemProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  //to get cart collection
  Future<CollectionReference<Map<String, dynamic>>?> _getCartCollection() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      print('User not logged in');
      return null;
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cartItems');
  }

  //  Add to cart
  Future<void> addToCart(CartItem item) async {
    try {
      final cartCollection = await _getCartCollection();
      if (cartCollection == null) return;

      final index = _cartItems.indexWhere((i) => i.productId == item.productId);
      if (index != -1) {
        _cartItems[index].quantity += item.quantity;
        await cartCollection.doc(item.productId).update({
          'quantity': _cartItems[index].quantity,
        });
      } else {
        _cartItems.add(item);
        await cartCollection.doc(item.productId).set(item.toJson());
      }
      notifyListeners();
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  // Fetch all cart items
  Future<void> fetchCartItems() async {
    try {
      final cartCollection = await _getCartCollection();
      if (cartCollection == null) return;

      final snapshot = await cartCollection.get();
      _cartItems.clear();
      for (var doc in snapshot.docs) {
        _cartItems.add(CartItem.fromFirestore(doc));
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  //  Increase quantity
  Future<void> increaseQuantity(String productId) async {
    try {
      final cartCollection = await _getCartCollection();
      if (cartCollection == null) return;

      final index = _cartItems.indexWhere((item) => item.productId == productId);
      if (index != -1) {
        _cartItems[index].quantity += 1;
        await cartCollection.doc(productId).update({
          'quantity': _cartItems[index].quantity,
        });
        notifyListeners();
      } else {
        print('Item not found in cart');
      }
    } catch (e) {
      print('Error increasing item quantity: $e');
    }
  }

  // Decrease quantity or remove item
  Future<void> decreaseQuantity(String productId) async {
    try {
      final cartCollection = await _getCartCollection();
      if (cartCollection == null) return;

      final index = _cartItems.indexWhere((item) => item.productId == productId);
      if (index != -1) {
        if (_cartItems[index].quantity > 1) {
          _cartItems[index].quantity -= 1;
          await cartCollection.doc(productId).update({
            'quantity': _cartItems[index].quantity,
          });
        } else {
          await cartCollection.doc(productId).delete();
          _cartItems.removeAt(index);
        }
        notifyListeners();
      } else {
        print('Item not found in cart');
      }
    } catch (e) {
      print('Error decreasing item quantity: $e');
    }
  }
}
