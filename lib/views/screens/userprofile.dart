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
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isUploading = false;

  Future<void> _uploadAndSaveImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked == null) return;

    setState(() => isUploading = true);

    final file = File(picked.path);
    final imgUrl = await CloudinaryService.uploadImageToCloudinary(file);

    if (imgUrl != null) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'image': imgUrl,
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final currentUser = userProvider.user;
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          profileImageUrl: imgUrl,
        );
        userProvider.setUser(updatedUser);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile image updated')),
      );
    }

    setState(() => isUploading = false);
  }

  Future<void> _showEditProfileSheet() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user!;
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final addressController = TextEditingController(text: user.address ?? '');

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("✏️ Edit Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _uploadAndSaveImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: user.profileImageUrl != null
                    ? NetworkImage('${user.profileImageUrl!}?v=${DateTime.now().millisecondsSinceEpoch}')
                    : null,
                backgroundColor: Colors.orange.withOpacity(0.2),
                child: user.profileImageUrl == null
                    ? const Icon(Icons.person, size: 40, color: Colors.orange)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final uid = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance.collection('users').doc(uid).update({
                  'name': nameController.text.trim(),
                  'email': emailController.text.trim(),
                  'address': addressController.text.trim(),
                });

                final updatedUser = user.copyWith(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  address: addressController.text.trim(),
                );

                userProvider.setUser(updatedUser);

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Provider.of<UserProvider>(context, listen: false).clearUser();
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Information', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.orange.withOpacity(0.2),
                  backgroundImage: user.profileImageUrl != null
                      ? NetworkImage('${user.profileImageUrl!}?v=${DateTime.now().millisecondsSinceEpoch}')
                      : null,
                  child: user.profileImageUrl == null
                      ? const Icon(Icons.person, size: 50, color: Colors.orange)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: _uploadAndSaveImage,
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  ),
                ),
                if (isUploading)
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: Colors.orange),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(user.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.orange, fontSize: 16)),
            const SizedBox(height: 32),

            ListTile(
              leading: const Icon(Icons.edit, color: Colors.orange),
              title: const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.orange),
              onTap: _showEditProfileSheet,
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.lock, color: Colors.orange),
              title: const Text("Change Password", style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.orange),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("🔒 Change Password"),
                    content: const Text("Password change functionality will be added."),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.history, color: Colors.orange),
              title: const Text("Order History", style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.orange),
              onTap: () {
                Navigator.pushNamed(context, '/orderhistory');
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.contact_support, color: Colors.orange),
              title: const Text("Contact Us", style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.orange),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("📞 Contact Us"),
                    content: const Text("Reach us at: support@brewmate.com"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 1),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Log out', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
