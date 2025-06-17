import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<String> _favoriteItems = [];
  List<String> get favoriteItems => List.unmodifiable(_favoriteItems);

  Future<CollectionReference<Map<String, dynamic>>?> _getFavoritesCollection() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      print('User not logged in');
      return null;
    }
    return FirebaseFirestore.instance
        .collection('users') 
        .doc(uid)
        .collection('favorites');
  }

  //  Add to favorites
  Future<void> addToFavorites(String productId) async {
    final favoritesCollection = await _getFavoritesCollection();
    if (favoritesCollection == null) return;

    await favoritesCollection.add({'productId': productId});
    _favoriteItems.add(productId);
    notifyListeners();
  }

  // Fetch favorites
  Future<void> fetchFavorites() async {
    final favoritesCollection = await _getFavoritesCollection();
    if (favoritesCollection == null) return;

    final snapshot = await favoritesCollection.get();
    _favoriteItems.clear();
    for (var doc in snapshot.docs) {
      _favoriteItems.add(doc.data()['productId']);
    }
    notifyListeners();
  }

  // Remove from favorites
  Future<void> removeFromFavorites(String productId) async {
    final favoritesCollection = await _getFavoritesCollection();
    if (favoritesCollection == null) return;

    final snapshot = await favoritesCollection
        .where('productId', isEqualTo: productId)
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    _favoriteItems.remove(productId);
    notifyListeners();
  }
}
