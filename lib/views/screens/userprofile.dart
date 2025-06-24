import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/services/cloudinaryservice.dart';
import 'package:brewmate_coffee_app/provider/userprovider.dart';
import 'package:brewmate_coffee_app/models/appuser.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppUser? user;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
  }

  Future<void> _uploadAndSaveImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() => isUploading = true);

    final file = File(picked.path);
    final imgUrl = await CloudinaryService.uploadImageToCloudinary(file);

    if (imgUrl != null) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'image': imgUrl,
      });

      final updatedUser = user!.copyWith(image: imgUrl);
      Provider.of<UserProvider>(context, listen: false).setUser(updatedUser);

      setState(() {
        user = updatedUser;
        isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile image updated')),
      );
    } else {
      setState(() => isUploading = false);
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Provider.of<UserProvider>(context, listen: false).clearUser();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Information'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar
            GestureDetector(
              onTap: _uploadAndSaveImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        user!.profileImageUrl != null ? NetworkImage(user!.profileImageUrl!) : null,
                    child: user!.profileImageUrl == null
                        ? const Icon(Icons.person, size: 45, color: Colors.grey)
                        : null,
                  ),
                  if (isUploading)
                    const CircularProgressIndicator(
                      color: Colors.orange,
                      strokeWidth: 3,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Name & Email
            Text(
              user!.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(user!.email, style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 30),

            // Menu
            _buildMenuItem(context, Icons.edit, 'Edit Profile'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.lock, 'Change Password'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.history, 'Order History'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.contact_support, 'Contact Us'),
            const Divider(height: 1),

            const SizedBox(height: 30),

            // Logout Button
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Log out', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => print('$title tapped'),
    );
  }
}
