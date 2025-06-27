import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brewmate_coffee_app/models/products.dart';

class ProductProvider with ChangeNotifier {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');

  final List<Product> _allProducts = [];
  List<Product> _displayedProducts = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Product> get allProducts => List.unmodifiable(_displayedProducts);

  /// Fetch all products from Firestore (initial load or 'All' tab)
  Future<void> fetchAllProducts() async {
    _isLoading = true;
    try {
      final snapshot = await _productCollection.get();
      _allProducts.clear();
      _displayedProducts.clear();

      for (var doc in snapshot.docs) {
        final product = Product.fromFirestore(doc);
        _allProducts.add(product);
      }

      // Set displayed to all
      _displayedProducts = List.from(_allProducts);
    } catch (e) {
      print('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Filter products by category ID
  Future<void> fetchProductsByCategoryId(String categoryId) async {
    if (categoryId.isEmpty) {
      // 'All' tab clicked — show all loaded products
      _displayedProducts = List.from(_allProducts);
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _displayedProducts = _allProducts
          .where((product) => product.categoryId == categoryId)
          .toList();
    } catch (e) {
      print('Error filtering products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
Future<Product?> fetchProductbyId(String productId) async {
  try {
    final doc = await _productCollection.doc(productId).get();

    if (doc.exists) {
      return Product.fromFirestore(doc);
    } else {
      print('Product with ID $productId not found.');
      return null;
    }
  } catch (e) {
    print('Error fetching product by id: $e');
    throw Exception('Error fetching product by id: $e');
  }
}
void filterProductsByName(String query) {
  if (query.isEmpty) {
    _displayedProducts = List.from(_allProducts); // Reset to all
  } else {
    _displayedProducts = _allProducts.where((product) =>
      product.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  notifyListeners();
}
}
