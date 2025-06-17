
import 'package:brewmate_coffee_app/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
// import '../screens/home_screen.dart';
// import '../screens/cart_screen.dart';
// import '../screens/favorites_screen.dart';
// import '../screens/notification_screen.dart';

class CustomBottomNavPage extends StatefulWidget {
  const CustomBottomNavPage({super.key});

  @override
  State<CustomBottomNavPage> createState() => _CustomBottomNavPageState();
}

class _CustomBottomNavPageState extends State<CustomBottomNavPage> {
  int _selectedIndex = 0;

  final List<String> _svgIcons = [
    'assets/icons/home.svg',
    'assets/icons/cart.svg',
    'assets/icons/favorite.svg',
    'assets/icons/bell.svg',
  ];

  final List<String> _labels = ['Home', 'Cart', 'Favorites', 'Notification'];

  final List<Widget> _pages = const [
    HomeScreen(),
    // CartScreen(),
    // FavoritesScreen(),
    // NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildCustomNavBar(),
    );
  }

  Widget _buildCustomNavBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_svgIcons.length, (index) {
            final isSelected = _selectedIndex == index;

            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: index == 1
                        ? badges.Badge(
                            badgeContent: const Text(
                              '2',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            position: badges.BadgePosition.topEnd(top: -6, end: -6),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.red,
                              padding: EdgeInsets.all(5),
                            ),
                            child: SvgPicture.asset(
                              _svgIcons[index],
                              colorFilter: ColorFilter.mode(
                                isSelected ? Colors.white : Colors.black,
                                BlendMode.srcIn,
                              ),
                              height: 24,
                            ),
                          )
                        : SvgPicture.asset(
                            _svgIcons[index],
                            colorFilter: ColorFilter.mode(
                              isSelected ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                            height: 24,
                          ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _labels[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.orange : Colors.grey.shade600,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
