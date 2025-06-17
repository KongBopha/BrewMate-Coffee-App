import 'package:brewmate_coffee_app/widgets/bodycontainer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: const Icon(Icons.location_on_outlined),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_pin),
            onPressed: () {},
          ),
        ],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to BrewMate"),
            Text("Enjoy your favorite drinks",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: const SafeArea(child: BodyContainer()),
    );
  }
}
