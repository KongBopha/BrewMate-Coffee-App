// product_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id; // Unique identifier for the product
  final String name;
  final String? description;
  final double price;
  final double rating;
  final String size;
  final String? imageUrl;
  final bool isAvailable;
  final String categoryId; 
  final List<String>? customizations;  
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.rating,
    required this.size,
    this.imageUrl,
    this.isAvailable = true,
    required this.categoryId,
    this.customizations,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'],
      price: (data['price'] as num).toDouble(),
      rating: (data['rating'] as num).toDouble(),
      size: data['size'] ?? '',
      imageUrl: data['imageUrl'],
      isAvailable: data['isAvailable'] ?? true,
      categoryId: data['categoryId'] ?? '',
      customizations: (data['customizations'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      createdAt: data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null,
      updatedAt: data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'size': size,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'categoryId': categoryId,
      'customizations': customizations,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}