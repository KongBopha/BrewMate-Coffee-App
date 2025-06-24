import 'dart:async';
import 'package:brewmate_coffee_app/provider/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/models/appuser.dart';
import 'package:brewmate_coffee_app/services/authservice.dart';
import 'package:brewmate_coffee_app/views/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Animation
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Delay & redirect
    Timer(Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final profile = await AuthService().fetchUserProfile(user.uid);
        if (profile != null) {
          Provider.of<UserProvider>(context, listen: false).setUser(profile);
        }
      }
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.brown[50],
    body: FadeTransition(
      opacity: _animation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/appLogo.png',
              width: 120,
            ),
            SizedBox(height: 20),
            Text(
              "BrewMate Coffee",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Brewing joy in every cup ☕",
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[400],
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              color: Colors.brown[300],
            )
          ],
        ),
      ),
    ),
  );
}
}
