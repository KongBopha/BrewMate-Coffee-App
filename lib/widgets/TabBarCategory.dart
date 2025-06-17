import 'package:brewmate_coffee_app/provider/categoryprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/models/category.dart';

class TabBarCategory extends StatefulWidget {
  const TabBarCategory({super.key});

  @override
  State<TabBarCategory> createState() => _TabBarCategoryState();
}

class _TabBarCategoryState extends State<TabBarCategory> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    setState(() {
      _categories = Provider.of<CategoryProvider>(context, listen: false).categories;
      _tabController = TabController(length: _categories.length, vsync: this);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    if (_isLoading) {
      return const CircularProgressIndicator();
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.orange,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          indicator: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(12),
          ),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          tabs: _categories.map((cat) {
            return Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(cat.name),
              ),
            );
          }).toList(),
          onTap: (index) {
            final selectedId = _categories[index].id;
            if (selectedId == 'all') {
              productProvider.fetchAllProducts();
            } else {
              productProvider.fetchProductsByCategoryId(selectedId);
            }
          },
        ),


      ],
    );
  }
}
