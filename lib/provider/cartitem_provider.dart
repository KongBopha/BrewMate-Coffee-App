import 'dart:convert';

import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItemProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  int get cartCount {
    int count = 0;
    for (var item in _cartItems) {
      count += item.quantity;
    }
    return count;
  }

  void clearCart() {
    _cartItems.clear();
    saveCartToPrefs(); //  Update shared prefs
    notifyListeners();
  }

  // sync local and firestore//
  Future<void> syncCartOnStart() async {
  try {
    // Fetch from Firestore
    await fetchCartItems();

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJsonList = _cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cartItems', cartJsonList);
  } catch (e) {
    print('Error syncing cart: $e');
  }
}

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
      await saveCartToPrefs(); //  Save after update
      notifyListeners();
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<void> fetchCartItems() async {
    try {
      final cartCollection = await _getCartCollection();
      if (cartCollection == null) return;

      final snapshot = await cartCollection.get();
      _cartItems.clear();
      for (var doc in snapshot.docs) {
        _cartItems.add(CartItem.fromFirestore(doc));
      }
      await saveCartToPrefs(); // Sync shared prefs
      notifyListeners();
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

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
        await saveCartToPrefs(); //  Update local storage
        notifyListeners();
      }
    } catch (e) {
      print('Error increasing item quantity: $e');
    }
  }

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
        await saveCartToPrefs(); // Update local storage
        notifyListeners();
      }
    } catch (e) {
      print('Error decreasing item quantity: $e');
    }
  }

  /// Save cartItems to SharedPreferences
  Future<void> saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJsonList =
        _cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cart_items', cartJsonList);
  }

  ///  Load cartItems from SharedPreferences
  Future<void> loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartJsonList = prefs.getStringList('cart_items');
    if (cartJsonList != null) {
      _cartItems.clear();
      _cartItems.addAll(
        cartJsonList.map((itemJson) {
          return CartItem.fromJson(jsonDecode(itemJson));
        }),
      );
      notifyListeners();
    }
  }
  Future<void> clearLocalCart() async {
  _cartItems.clear();
  notifyListeners();

  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('cartItems');
}

}
