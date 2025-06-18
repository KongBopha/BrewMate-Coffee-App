import 'package:flutter/material.dart';

class BrewMateAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfilePressed;

  const BrewMateAppBar({Key? key, this.onProfilePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      leading: const Icon(Icons.location_on_outlined),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_pin),
          onPressed: onProfilePressed ?? () {},
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
