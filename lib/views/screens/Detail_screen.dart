import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:brewmate_coffee_app/models/products.dart';
import 'package:brewmate_coffee_app/models/cartitem.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/provider/favoriteprovider.dart';
import 'package:brewmate_coffee_app/provider/cartitem_provider.dart';
import 'package:brewmate_coffee_app/widgets/customBottomNavBar.dart';

class DetailScreen extends StatefulWidget {
  final String productId;

  const DetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Product?> _productFuture;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _productFuture = _fetchProduct();
  }

  Future<Product?> _fetchProduct() async {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

    final product = await productProvider.fetchProductbyId(widget.productId);
    if (product != null) {
      final isFav = favoriteProvider.isFavorite(product.id);
      setState(() {
        _isFavorite = isFav;
      });
    }
    return product;
  }

  void _toggleFavorite(String productId) {
    final favProvider = Provider.of<FavoriteProvider>(context, listen: false);
    setState(() {
      _isFavorite = !_isFavorite;
      _isFavorite
          ? favProvider.addToFavorites(productId)
          : favProvider.removeFromFavorites(productId);
    });
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text('You must log in to order this product.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product?>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final product = snapshot.data;
        if (product == null) {
          return const Scaffold(
            body: Center(child: Text('Product not found')),
          );
        }

        return Scaffold(
          body: Consumer<CartItemProvider>(
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

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 280,
                    pinned: true,
                    backgroundColor: Colors.orange,
                    actions: [
                      IconButton(
                        onPressed: () => _toggleFavorite(product.id),
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                          color: _isFavorite ? Colors.redAccent : Colors.black,
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        product.imageUrl ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                      ),
                      title: Text(
                        product.name,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 3)],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${product.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (cartItem.quantity == 0)
                            ElevatedButton(
                              onPressed: () {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user == null) {
                                  _showLoginDialog();
                                } else {
                                  cartProvider.addToCart(CartItem(
                                    productId: product.id,
                                    name: product.name,
                                    price: product.price,
                                    imageUrl: product.imageUrl ?? '',
                                    quantity: 1,
                                  ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                minimumSize: const Size(double.infinity, 48),
                              ),
                              child: const Text("Add to Cart"),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () => cartProvider.decreaseQuantity(product.id),
                                    ),
                                    Text(cartItem.quantity.toString()),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () => cartProvider.increaseQuantity(product.id),
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
                                          builder: (_) => const CustomBottomNavPage(initialIndex: 1),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 30),
                          const Text(
                            "Description",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description ?? "No description available.",
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
