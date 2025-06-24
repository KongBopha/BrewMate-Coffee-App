import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/provider/cartitem_provider.dart';

class CartQuantityWidget extends StatelessWidget {
  final String productId;

  const CartQuantityWidget({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartItemProvider>(context);
    // Check if the item exists in the cart, if not assign null
    final CartItem? item = cartProvider.cartItems.where((i) => i.productId == productId).isEmpty
        ? null
        : cartProvider.cartItems.firstWhere((i) => i.productId == productId);

    // If item is not found, return empty widget
    if (item == null) return const SizedBox();

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
          onPressed: () {
            cartProvider.decreaseQuantity(productId);
          },
        ),
        Text(item.quantity.toString(), style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: Colors.orange),
          onPressed: () {
            cartProvider.increaseQuantity(productId);
          },
        ),
      ],
    );
  }
}
