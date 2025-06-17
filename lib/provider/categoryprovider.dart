import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brewmate_coffee_app/models/category.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [];
  String _selectedCategoryId = 'all';

  List<Category> get categories => List.unmodifiable(_categories);
  String get selectedCategoryId => _selectedCategoryId;

  final CollectionReference _categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _categoryCollection.get();
      _categories.clear();

      // Add the "All" tab manually
      _categories.add(
        Category(id: 'all', name: 'All'),
      );

      for (var doc in snapshot.docs) {
        _categories.add(Category.fromFirestore(doc));
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }
}
