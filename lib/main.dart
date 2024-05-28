import 'package:final_project_haijo/screens/categories_screen.dart';
import 'package:final_project_haijo/screens/favorites_screen.dart';
import 'package:final_project_haijo/screens/main_screen.dart';
import 'package:final_project_haijo/screens/pengaturan_screen.dart';
import 'package:final_project_haijo/screens/profile_screen.dart';
import 'package:final_project_haijo/screens/sign_in_screen.dart';
import 'package:final_project_haijo/screens/sign_up_screen.dart';
import 'package:final_project_haijo/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haijo Library',
      theme: ThemeData(),
      home: PengaturanScreen(),
      routes: {
        // '/homescreen': (context) => const HomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/profile': (context) => ProfileScreen(),
        '/main': (context) => MainScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/favorite': (context) => FavoritesScreen(),
      },
    );
  }
}
