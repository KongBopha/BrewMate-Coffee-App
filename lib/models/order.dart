import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItems {
  final String orderId;
  final List<CartItem> items;
  final double subtotal;
  final double totalPrice;
  final String status; // e.g. 'pending', 'completed'
  final DateTime createdAt;
  final double deliveryFee;
  final String deliveryOption; // 'pickup' or 'delivery'
  final String? deliveryAddress;
  final String? paymentMethod;
   // null if pickup

  OrderItems({
    required this.orderId,
    required this.subtotal,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.deliveryFee,
    required this.deliveryOption,
    this.deliveryAddress,
    this.paymentMethod
  });

  Map<String, dynamic> toJson() => {
     
    'items': items.map((i) => i.toJson()).toList(),
    'totalPrice': totalPrice,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'deliveryFee': deliveryFee,
    'deliveryOption': deliveryOption,
    'deliveryAddress': deliveryAddress,
    'paymentmethod' : paymentMethod,
    'subtotal': subtotal,
  };

  factory OrderItems.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderItems(
      orderId: doc.id,
      items: (data['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      subtotal: data['subtotal'],
      totalPrice: data['totalPrice'],
      status: data['status'],
      createdAt: DateTime.parse(data['createdAt']),
      deliveryFee: data['deliveryFee'] ?? 0.0,
      deliveryOption: data['deliveryOption'],
      deliveryAddress: data['deliveryAddress'],
      paymentMethod: data['paymentmethod'],
    );
  }
}
