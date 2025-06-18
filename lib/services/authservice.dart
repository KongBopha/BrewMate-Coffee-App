import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewmate_coffee_app/models/appuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email and password
  Future<AppUser?> registerAccount ({
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
    String? address
  }) async {  
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      final uid = userCredential.user?.uid;
      if (uid != null) {
        // Create a new AppUser object
        AppUser appUser = AppUser(
          id: uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          address: address
        );

        // Save the user data to Firestore
        await _firestore.collection('users').doc(uid).set(appUser.toJson());
        return appUser;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
  // Sign in with email and password directly
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

  Future<void> signOut() async => await _auth.signOut();

  fetchUserProfile(String uid) {}

}