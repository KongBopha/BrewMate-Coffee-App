import 'package:brewmate_coffee_app/widgets/customBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/models/products.dart';
import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/provider/cartitem_provider.dart';

class DetailScreen extends StatelessWidget {
  final String productId;

  const DetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return FutureBuilder<Product?>(
      future: productProvider.fetchProductbyId(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final product = snapshot.data;

        if (product == null) {
          return const Scaffold(
            body: Center(child: Text("Product not found")),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Product Details"),
            backgroundColor: Colors.orange,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<CartItemProvider>(
              builder: (context, cartProvider, _) {
                final cartItem = cartProvider.cartItems.firstWhere(
                  (item) => item.productId == product.id,
                  orElse: () => CartItem(
                    productId: product.id,
                    name: product.name,
                    price: product.price,
                    imageUrl: product.imageUrl ?? '',
                    quantity: 0,
                  ),
                );

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          product.imageUrl ?? '',
                          width: 150,
                          height: 150,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("\$${product.price}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.orange)),
                      const SizedBox(height: 20),

                      /// Add to Cart or Quantity buttons
                      if (cartItem.quantity == 0)
                        ElevatedButton(
                          onPressed: () {
                            cartProvider.addToCart(CartItem(
                              productId: product.id,
                              name: product.name,
                              price: product.price,
                              imageUrl: product.imageUrl ?? '',
                              quantity: 1,
                            ));
                          },
                          child: const Text("Add to Cart"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    cartProvider
                                        .decreaseQuantity(product.id);
                                  },
                                ),
                                Text(cartItem.quantity.toString(),
                                    style: const TextStyle(fontSize: 16)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cartProvider
                                        .increaseQuantity(product.id);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.shopping_cart),
                                label: const Text("View Cart"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const CustomBottomNavPage(
                                          initialIndex: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      const Text("Description",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(product.description ?? "No description"),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
