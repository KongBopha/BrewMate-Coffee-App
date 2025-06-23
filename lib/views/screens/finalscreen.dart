import 'package:brewmate_coffee_app/widgets/appbar_widget.dart';
import 'package:brewmate_coffee_app/widgets/customBottomNavBar.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrewMateAppBar(
        onProfilePressed: () {
          // Handle profile action
        },
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          // user location and store location
        ],
      ),
    ),
    bottomNavigationBar: const CustomBottomNavPage(),
    );
  }
}