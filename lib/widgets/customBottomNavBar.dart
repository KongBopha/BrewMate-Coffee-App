import 'package:brewmate_coffee_app/provider/cartitem_provider.dart';
import 'package:brewmate_coffee_app/views/screens/myfavorite.dart';
import 'package:brewmate_coffee_app/views/screens/cartscreen.dart';
import 'package:brewmate_coffee_app/views/screens/home_screen.dart';
import 'package:brewmate_coffee_app/views/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class CustomBottomNavPage extends StatefulWidget {
  final int initialIndex;

  const CustomBottomNavPage({super.key, required this.initialIndex});

  @override
  State<CustomBottomNavPage> createState() => _CustomBottomNavPageState();
}


class _CustomBottomNavPageState extends State<CustomBottomNavPage> {
  late int _selectedIndex = 0;

  final List<String> _svgIcons = [
    'assets/icons/home.svg',
    'assets/icons/cart.svg',
    'assets/icons/favorite.svg',
    'assets/icons/bell.svg',
  ];

  final List<String> _labels = ['Home', 'Cart', 'Favorites', 'Notification'];

  final List<Widget> _pages = const [
    HomeScreen(),
    CartScreen(),
    MyFavoriteScreen(),
    NotificationScreen(),
  ];
    @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; 
  }
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

          Widget iconWidget = SvgPicture.asset(
            _svgIcons[index],
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : Colors.black,
              BlendMode.srcIn,
            ),
            height: 24,
          );

          // Show badge only for Cart tab (index 1)
          if (index == 1) {
            iconWidget = Consumer<CartItemProvider>(
              builder: (_, cartProvider, child) {
                final cartCount = cartProvider.cartCount;
                return cartCount > 0
                    ? badges.Badge(
                        badgeContent: Text(
                          cartCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        position:
                            badges.BadgePosition.topEnd(top: -6, end: -6),
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: Colors.red,
                          padding: EdgeInsets.all(5),
                        ),
                        child: child!,
                      )
                    : child!;
              },
              child: iconWidget,
            );
          }

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
                  child: iconWidget,
                ),
                const SizedBox(height: 4),
                Text(
                  _labels[index],
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        isSelected ? Colors.orange : Colors.grey.shade600,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
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
