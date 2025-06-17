import 'package:brewmate_coffee_app/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadSampleData() async {
  final categoryRef = FirebaseFirestore.instance.collection('categories');
  final productRef = FirebaseFirestore.instance.collection('products');

  final categoryDocs = <String, String>{};

  final categories = [
    'Espresso',
    'Macchiato',
    'Latte',
  ];
  

  // Upload categories and keep their IDs
  for (final name in categories) {
    final doc = await categoryRef.add({'name': name});
    categoryDocs[name] = doc.id;
  }

  final now = DateTime.now();

  // Define 6 products: 2 for each category
  final products = [
    // Espresso
    {
      'name': 'Classic Espresso',
      'description': 'Rich and strong espresso shot',
      'price': 2.50,
      'rating': 4.7,
      'deliveryCost': 0.50,
      'size': 'Small',
      'imageUrl': null,
      'isAvailable': true,
      'categoryName': 'Espresso',
      'customizations': ['Extra shot', 'Sugar'],
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    },
    {
      'name': 'Double Espresso',
      'description': 'Two shots of espresso for double energy',
      'price': 3.50,
      'rating': 4.8,
      'deliveryCost': 0.60,
      'size': 'Small',
      'imageUrl': null,
      'isAvailable': true,
      'categoryName': 'Espresso',
      'customizations': ['Extra shot', 'No sugar'],
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    },

    // Macchiato
    {
      'name': 'Caramel Macchiato',
      'description': 'Espresso with caramel and steamed milk',
      'price': 3.99,
      'rating': 4.6,
      'deliveryCost': 0.70,
      'size': 'Medium',
      'imageUrl': null,
      'isAvailable': true,
      'categoryName': 'Macchiato',
      'customizations': ['Extra caramel', 'Whipped cream'],
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    },
    {
      'name': 'Vanilla Macchiato',
      'description': 'Smooth vanilla flavored espresso',
      'price': 3.75,
      'rating': 4.5,
      'deliveryCost': 0.65,
      'size': 'Medium',
      'imageUrl': null,
      'isAvailable': true,
      'categoryName': 'Macchiato',
      'customizations': ['Extra vanilla syrup'],
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    },

    // Latte
    {
      'name': 'Classic Latte',
      'description': 'Creamy steamed milk with espresso',
      'price': 3.50,
      'rating': 4.4,
      'deliveryCost': 0.60,
      'size': 'Large',
      'imageUrl': null,
      'isAvailable': true,
      'categoryName': 'Latte',
      'customizations': ['Soy milk', 'Extra foam'],
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    },
    {
      'name': 'Iced Latte',
      'description': 'Cold and refreshing iced latte',
      'price': 3.75,
      'rating': 4.3,
      'deliveryCost': 0.65,
      'size': 'Large',
      'imageUrl': null,
      'isAvailable': true,
      'categoryName': 'Latte',
      'customizations': ['Almond milk', 'No sugar'],
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    },
  ];

  // Upload products with category IDs
  for (final p in products) {
    final product = Product(
      id: '',
      name: p['name'] as String,
      description: p['description'] as String?,
      price: p['price'] as double,
      rating: p['rating'] as double,
      size: p['size'] as String,
      imageUrl: p['imageUrl'] as String?,
      isAvailable: p['isAvailable'] as bool,
      categoryId: categoryDocs[p['categoryName']] ?? '',
      customizations: (p['customizations'] as List<String>?),
      createdAt: DateTime.parse(p['createdAt'] as String),
      updatedAt: DateTime.parse(p['updatedAt'] as String),
    );

    await productRef.add(product.toJson());
  }

  print('Uploaded 3 categories and 6 products successfully!');
}
