import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String productId;   
  final String name;
  int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'quantity': quantity,
    'price': price,
    'imageUrl': imageUrl,
  };

  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItem(
      productId: data['productId'],
      name: data['name'],
      quantity: data['quantity'],
      price: data['price'],
      imageUrl: data['imageUrl'],
    );
  }
  factory CartItem.fromJson(Map<String, dynamic> json) {
  return CartItem(
    productId: json['productId'],
    name: json['name'],
    quantity: json['quantity'],
    price: json['price'],
    imageUrl: json['imageUrl'],
  );
}


  
}
