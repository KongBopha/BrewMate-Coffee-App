import 'dart:io';
import 'package:brewmate_coffee_app/models/products.dart';
import 'package:brewmate_coffee_app/services/cloudinaryservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<void> uploadSampleData() async {
  final categoryRef = FirebaseFirestore.instance.collection('categories');
  final productRef = FirebaseFirestore.instance.collection('products');

  final categoryDocs = <String, String>{};

  final categories = [
    'Espresso',
    'Macchiato',
    'Latte',
  ];

  final now = DateTime.now();

final List<Map<String, dynamic>> rawproducts = [
  // Espresso (6 total)
  {
    'name': 'Classic Espresso',
    'description': 'Rich and strong espresso shot',
    'price': 2.50,
    'rating': 4.7,
    'deliveryCost': 0.50,
    'size': 'Small',
    'imageAssetPath': 'assets/images/espresso1.png',
    'categoryName': 'Espresso',
    'customizations': ['Extra shot', 'Sugar'],
  },
  {
    'name': 'Double Espresso',
    'description': 'Two shots of espresso for double energy',
    'price': 3.50,
    'rating': 4.8,
    'deliveryCost': 0.60,
    'size': 'Small',
    'imageAssetPath': 'assets/images/espresso2.png',
    'categoryName': 'Espresso',
    'customizations': ['Extra shot', 'No sugar'],
  },
  {
    'name': 'Ristretto',
    'description': 'Short and more concentrated espresso shot',
    'price': 2.80,
    'rating': 4.6,
    'deliveryCost': 0.50,
    'size': 'Small',
    'imageAssetPath': 'assets/images/espresso3.png',
    'categoryName': 'Espresso',
    'customizations': ['No sugar'],
  },
  {
    'name': 'Lungo',
    'description': 'Espresso with more water, less intense',
    'price': 2.70,
    'rating': 4.4,
    'deliveryCost': 0.50,
    'size': 'Medium',
    'imageAssetPath': 'assets/images/espresso4.png',
    'categoryName': 'Espresso',
    'customizations': ['Less water', 'Sugar'],
  },
  {
    'name': 'Affogato Espresso',
    'description': 'Espresso poured over vanilla ice cream',
    'price': 4.00,
    'rating': 4.9,
    'deliveryCost': 0.70,
    'size': 'Medium',
    'imageAssetPath': 'assets/images/espresso5.png',
    'categoryName': 'Espresso',
    'customizations': ['Extra shot'],
  },
  {
    'name': 'Iced Espresso',
    'description': 'Espresso served over ice',
    'price': 3.20,
    'rating': 4.5,
    'deliveryCost': 0.60,
    'size': 'Small',
    'imageAssetPath': 'assets/images/espresso6.png',
    'categoryName': 'Espresso',
    'customizations': ['No sugar', 'Extra ice'],
  },

  // // Macchiato (6 total)
  {
    'name': 'Caramel Macchiato',
    'description': 'Espresso with caramel and steamed milk',
    'price': 3.99,
    'rating': 4.6,
    'deliveryCost': 0.70,
    'size': 'Medium',
    'imageAssetPath': 'assets/images/macchiato1.png',
    'categoryName': 'Macchiato',
    'customizations': ['Extra caramel', 'Whipped cream'],
  },
  {
    'name': 'Vanilla Macchiato',
    'description': 'Smooth vanilla flavored espresso',
    'price': 3.75,
    'rating': 4.5,
    'deliveryCost': 0.65,
    'size': 'Medium',
    'imageAssetPath': 'assets/images/macchiato2.png',
    'categoryName': 'Macchiato',
    'customizations': ['Extra vanilla syrup'],
  },
  {
    'name': 'Hazelnut Macchiato',
    'description': 'Espresso with hazelnut syrup and milk',
    'price': 4.20,
    'rating': 4.7,
    'deliveryCost': 0.70,
    'size': 'Medium',
    'imageAssetPath': 'assets/images/macchiato3.jpg',
    'categoryName': 'Macchiato',
    'customizations': ['Whipped cream'],
  },
  {
    'name': 'Mocha Macchiato',
    'description': 'Macchiato with chocolate and espresso',
    'price': 4.50,
    'rating': 4.8,
    'deliveryCost': 0.75,
    'size': 'Large',
    'imageAssetPath': 'assets/images/macchiato4.png',
    'categoryName': 'Macchiato',
    'customizations': ['Extra chocolate syrup'],
  },
  {
    'name': 'Iced Macchiato',
    'description': 'Chilled macchiato with ice cubes',
    'price': 4.00,
    'rating': 4.4,
    'deliveryCost': 0.70,
    'size': 'Medium',
    'imageAssetPath': 'assets/images/macchiato5.png',
    'categoryName': 'Macchiato',
    'customizations': ['Less sugar'],
  },
  {
    'name': 'Toffee Nut Macchiato',
    'description': 'Sweet toffee nut flavored macchiato',
    'price': 4.30,
    'rating': 4.6,
    'deliveryCost': 0.70,
    'size': 'Medium',
    'imageAssetPath': 'assets/images/macchiato6.png',
    'categoryName': 'Macchiato',
    'customizations': ['Extra toffee syrup'],
  },

  // Latte (6 total)
  {
    'name': 'Classic Latte',
    'description': 'Creamy steamed milk with espresso',
    'price': 3.50,
    'rating': 4.4,
    'deliveryCost': 0.60,
    'size': 'Large',
    'imageAssetPath': 'assets/images/latte1.png',
    'categoryName': 'Latte',
    'customizations': ['Soy milk', 'Extra foam'],
  },
  {
    'name': 'Iced Latte',
    'description': 'Cold and refreshing iced latte',
    'price': 3.75,
    'rating': 4.3,
    'deliveryCost': 0.65,
    'size': 'Large',
    'imageAssetPath': 'assets/images/latte2.png',
    'categoryName': 'Latte',
    'customizations': ['Almond milk', 'No sugar'],
  },
  {
    'name': 'Vanilla Latte',
    'description': 'Latte with vanilla flavor syrup',
    'price': 3.80,
    'rating': 4.5,
    'deliveryCost': 0.65,
    'size': 'Large',
    'imageAssetPath': 'assets/images/latte3.png',
    'categoryName': 'Latte',
    'customizations': ['Extra vanilla syrup'],
  },
  {
    'name': 'Caramel Latte',
    'description': 'Latte with caramel syrup and steamed milk',
    'price': 4.00,
    'rating': 4.6,
    'deliveryCost': 0.70,
    'size': 'Large',
    'imageAssetPath': 'assets/images/latte4.jpg',
    'categoryName': 'Latte',
    'customizations': ['Extra caramel'],
  },
  {
    'name': 'Mocha Latte',
    'description': 'Chocolate flavored latte',
    'price': 4.10,
    'rating': 4.7,
    'deliveryCost': 0.70,
    'size': 'Large',
    'imageAssetPath': 'assets/images/latte5.png',
    'categoryName': 'Latte',
    'customizations': ['Whipped cream'],
  },
  {
    'name': 'Iced Hazelnut Latte',
    'description': 'Hazelnut flavored iced latte',
    'price': 4.20,
    'rating': 4.5,
    'deliveryCost': 0.65,
    'size': 'Large',
    'imageAssetPath': 'assets/images/latte6.png',
    'categoryName': 'Latte',
    'customizations': ['No sugar', 'Extra ice'],
  },
];
 
// 1. Upload categories first and keep their IDs
  for (final name in categories) {
    final doc = await categoryRef.add({'name': name});
    categoryDocs[name] = doc.id;
  }

  // 2. Upload each product with image upload to Cloudinary
  for (final product in rawproducts) {
    try {
      // Load asset image as File for upload
      final byteData = await rootBundle.load(product['imageAssetPath']);
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(path.join(tempDir.path, path.basename(product['imageAssetPath'])));
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      // Upload image to Cloudinary and get URL
      final imageUrl = await CloudinaryService.uploadImageToCloudinary(tempFile);
      if (imageUrl == null) {
        print('❌ Failed to upload image for ${product['name']}');
        continue; // skip this product
      }

      // Prepare product data
      final productData = {
        'name': product['name'],
        'description': product['description'],
        'price': product['price'],
        'rating': product['rating'],
        'deliveryCost': product['deliveryCost'],
        'size': product['size'],
        'imageUrl': imageUrl,
        'isAvailable': true,
        'categoryId': categoryDocs[product['categoryName']] ?? '',
        'customizations': product['customizations'],
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };

      // Save product to Firestore
      await productRef.add(productData);

      print('✅ Uploaded and saved product: ${product['name']}');
    } catch (e) {
      print('❌ Error uploading product ${product['name']}: $e');
    }
  }  

  print('Uploaded 3 categories and 6 products successfully!');
}
