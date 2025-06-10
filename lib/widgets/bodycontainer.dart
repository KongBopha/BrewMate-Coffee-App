import 'package:flutter/material.dart';

class Bodycontainer extends StatelessWidget {
  const Bodycontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Orange background
        Container(
          height: 250,
          width: double.infinity,
          color: Colors.orange,
          padding: const EdgeInsets.only(top: 60, left: 20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Welcome to BrewMate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.person, color: Colors.white),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 4),
              Text(
                "Enjoy your favorite drinks",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              )
            ],
          ),
        ),

        // Floating content (Search + Banner)
        Positioned(
          top: 160,
          left: 0,
          right: 0,
          child: Column(
            children: [
              // Search Field
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      "Search Coffee",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Banner
              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
