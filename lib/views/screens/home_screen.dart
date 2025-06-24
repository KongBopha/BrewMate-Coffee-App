import 'package:brewmate_coffee_app/widgets/appbar_widget.dart';
import 'package:brewmate_coffee_app/widgets/bodycontainer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BrewMateAppBar(),
      body: SafeArea(child: BodyContainer()),
    );
  }
}
