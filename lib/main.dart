import 'package:brewmate_coffee_app/firebase_options.dart';
import 'package:brewmate_coffee_app/provider/cartitem_provider.dart';
import 'package:brewmate_coffee_app/provider/categoryprovider.dart';
import 'package:brewmate_coffee_app/provider/datauploader.dart';
import 'package:brewmate_coffee_app/provider/orderprovider.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/provider/userprovider.dart';
import 'package:brewmate_coffee_app/views/screens/cartscreen.dart';
import 'package:brewmate_coffee_app/views/screens/checkoutscreen.dart';
import 'package:brewmate_coffee_app/views/screens/splashscreen.dart';
import 'package:brewmate_coffee_app/views/auth/login_screen.dart';
import 'package:brewmate_coffee_app/views/auth/register_screen.dart';
import 'package:brewmate_coffee_app/views/screens/userprofile.dart';
import 'package:brewmate_coffee_app/widgets/customBottomNavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final cartItemProvider = CartItemProvider();
  await cartItemProvider.syncCartOnStart(); //
  //await uploadSampleData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider.value(value: cartItemProvider),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
            return CustomBottomNavPage(initialIndex: args);
          },
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    ),
  );
}

