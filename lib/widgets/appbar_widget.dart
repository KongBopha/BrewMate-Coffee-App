import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BrewMateAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfilePressed;

  const BrewMateAppBar({Key? key, this.onProfilePressed}) : super(key: key);

  Future<void> _getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permission permanently denied.')),
      );
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Location: ${position.latitude}, ${position.longitude}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      leading: IconButton(
        icon: const Icon(Icons.location_on_outlined),
        onPressed: () => _getCurrentLocation(context),
      ),
      actions: [
      IconButton(
        icon: const Icon(Icons.person_pin),
        onPressed: () {
          print("Person icon clicked");
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            print("Navigating to Register screen");
            Navigator.pushNamed(context, '/register');
          } else {
            print("Navigating to Profile screen");
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),

      ],
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome to BrewMate"),
          Text(
            "Enjoy your favorite drinks",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
