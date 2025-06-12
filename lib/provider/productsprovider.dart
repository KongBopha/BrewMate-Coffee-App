import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brewmate_coffee_app/models/products.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  List<Product> get allProducts => _allProducts;
  List<Product> get filteredProducts => _filteredProducts;

  /// Upload initial products to Firestore (call only once)
  Future<void> uploadInitialProducts() async {
    final List<Product> initialProducts = [
      Product(
        name: 'Espresso',
        description: 'Strong and bold coffee shot',
        price: 3.50,
        rating: 4.5,
        deliveryCost: 0.50,
        size: 'Small',
        imageUrl: 'assets/products/capuccino.png',
        category: 'Espresso',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Product(
        name: 'Latte',
        description: 'Creamy milk coffee',
        price: 4.00,
        rating: 4.3,
        deliveryCost: 0.70,
        size: 'Medium',
        imageUrl: 'assets/products/capuccino.png',
        category: 'Iced Latte',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Product(
        name: 'Cappuccino',
        description: 'Rich and foamy delight',
        price: 4.50,
        rating: 4.7,
        deliveryCost: 0.60,
        size: 'Large',
        imageUrl: 'assets/products/capuccino.png',
        category: 'Hot Coffee',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    try {
      final collection = FirebaseFirestore.instance.collection('products');

      for (var product in initialProducts) {
        await collection.add(product.toJson());
      }

      print(" Initial products uploaded successfully.");
    } catch (e) {
      print("Failed to upload initial products: $e");
    }
  }

  /// Fetch all products from Firestore and store them
  Future<void> fetchProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('createdAt', descending: true)
          .get();

      _allProducts = snapshot.docs.map((doc) {
        final data = doc.data();
        return Product.fromJson(data);
      }).toList();

      // Show all products initially
      _filteredProducts = _allProducts;

      notifyListeners();
    } catch (e) {
      print('❌ Error fetching products: $e');
    }
  }

  /// Filter products by user-selected category
  void filterProductsByCategory(String category) {
    if (category.toLowerCase() == 'all') {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where((product) =>
              product.category?.toLowerCase() == category.toLowerCase())
          .toList();
    }
    notifyListeners();
  }
}
