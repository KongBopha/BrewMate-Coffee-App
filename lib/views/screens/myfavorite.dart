import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/provider/favoriteprovider.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/models/products.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  late Future<List<Product>> _favoriteProductsFuture;

  @override
  void initState() {
    super.initState();
    _favoriteProductsFuture = _loadFavorites();
  }

  Future<List<Product>> _loadFavorites() async {
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    await favoriteProvider.fetchFavorites(); // Load favorite IDs from Firestore

    List<Product> favoriteProducts = [];
    for (String id in favoriteProvider.favoriteItems) {
      Product? product = await productProvider.fetchProductbyId(id);
      if (product != null) favoriteProducts.add(product);
    }
    return favoriteProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: _favoriteProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final favorites = snapshot.data ?? [];

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 35, left: 10),
                color: Colors.orange,
                height: 110,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      'My Favorite',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: favorites.isEmpty
                    ? const Center(child: Text("No favorites found."))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final product = favorites[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: product.imageUrl != null
                                  ? Image.network(product.imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
                                  : const Icon(Icons.local_cafe, size: 40, color: Colors.orange),
                              title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(product.description ?? ''),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("\$${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Icon(Icons.favorite, color: Colors.orange),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
