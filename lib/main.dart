import 'package:brewmate_coffee_app/firebase_options.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/views/home/home_screen.dart';
import 'package:brewmate_coffee_app/views/paymentMethod/payment_method.dart';
import 'package:brewmate_coffee_app/views/splashscreen/splashscreen.dart';
import 'package:brewmate_coffee_app/views/login/login_screen.dart';
import 'package:brewmate_coffee_app/views/login/register_screen.dart';
import 'package:brewmate_coffee_app/views/pickup/pickup.dart';
import 'package:brewmate_coffee_app/views/myfavorite/myfavorite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const MyFavoriteScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
        },
        // home: const PickUpScreen(),
      ),
    ),
  );
}
