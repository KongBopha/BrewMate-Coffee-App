import 'package:brewmate_coffee_app/views/screens/Detail_screen.dart';
import 'package:brewmate_coffee_app/widgets/customBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/widgets/tabbarcategory.dart';
import 'package:brewmate_coffee_app/widgets/cardwidget.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({super.key});

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.allProducts;

    return Column(
      children: [
        Stack(
          children: [
            _buildOrangeBackground(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildBannerImage(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const TabBarCategory(), // stays at top
        const SizedBox(height: 10),
        Expanded(
          child: productProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildProductGrid(products),
        ),
         
        
      ],
    );
  }

  Widget _buildOrangeBackground() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.orange,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Text("Search Coffee", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/banner.png',
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductGrid(List products) {
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('No products available in this category.'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return CardWidget(
            product: products[index],
            onAddToCart: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)
              => DetailScreen(productId: products[index].id)));
            },
          );
        },
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
