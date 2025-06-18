// product_model.dart
class Product {
  final String name;
  final String? description;
  final double price;
  final double rating;
  final double deliveryCost;
  final String size;
  final String? imageUrl;
  final bool isAvailable;
  final String? category;
  final List<String>? customizations;  
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    required this.name,
    this.description,
    required this.price,
    required this.rating,
    required this.deliveryCost,
    required this.size,
    this.imageUrl,
    this.isAvailable = true,
    this.category,
    this.customizations,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      size: json['size'] ?? '',
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'] ?? true,
      category: json['category'],
      customizations: (json['customizations'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'deliveryCost': deliveryCost,
      'size': size,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'category': category,
      'customizations': customizations,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}