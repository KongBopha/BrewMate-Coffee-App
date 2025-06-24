import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewmate_coffee_app/models/appuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register
  Future<AppUser?> registerAccount({
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
    String? address,
    String? profileImageUrl, // optional on register
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid != null) {
        AppUser appUser = AppUser(
          id: uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          profileImageUrl: profileImageUrl,
        );

        await _firestore.collection('users').doc(uid).set(appUser.toJson());
        return appUser;
      }
      return null;
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  // Login
  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user?.uid;
      if (uid != null) {
        final doc = await _firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          return AppUser.fromFirestore(doc.id, doc.data()!);
        }
      }
    } catch (e) {
      print('Sign in error: $e');
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user info
  Future<AppUser?> fetchUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromFirestore(doc.id, doc.data()!);
      }
    } catch (e) {
      print("Fetch user error: $e");
    }
    return null;
  }

  // Update user profile (e.g., name, address, profileImageUrl)
  Future<void> updateUserProfile(String uid, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('users').doc(uid).update(updates);
    } catch (e) {
      print("Update profile error: $e");
    }
  }

  // Get current user ID
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }
}
