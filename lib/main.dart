import 'package:brewmate_coffee_app/firebase_options.dart';
import 'package:brewmate_coffee_app/provider/categoryprovider.dart';
import 'package:brewmate_coffee_app/provider/datauploader.dart';
import 'package:brewmate_coffee_app/provider/productsprovider.dart';
import 'package:brewmate_coffee_app/provider/userprovider.dart';
import 'package:brewmate_coffee_app/views/screens/checkoutscreen.dart';
import 'package:brewmate_coffee_app/views/screens/home_screen.dart';
import 'package:brewmate_coffee_app/views/screens/splashscreen.dart';
import 'package:brewmate_coffee_app/views/auth/login_screen.dart';
import 'package:brewmate_coffee_app/views/auth/register_screen.dart';
import 'package:brewmate_coffee_app/widgets/customBottomNavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await uploadSampleData();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',  
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => const CustomBottomNavPage(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          
        },
      ),
    ),
  );
}