import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brewmate_coffee_app/models/appuser.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;
  AppUser? get user => _user;

  void setUser(AppUser? user) {
    _user = user;
    notifyListeners();
  }

  void updateProfileImage(String url) {
    if (_user != null) {
      _user = _user!.copyWith(profileImageUrl: url);
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      _user = AppUser.fromDocument(doc);  
      notifyListeners();
    }
  }
}
