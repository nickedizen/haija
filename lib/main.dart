import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:final_project_haija/screens/categories_screen.dart';
import 'package:final_project_haija/screens/main_screen.dart';
import 'package:final_project_haija/screens/sign_in_screen.dart';
import 'package:final_project_haija/screens/sign_up_screen.dart';
import 'package:final_project_haija/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haija Library',
      theme: ThemeData(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainScreen();
            } else {
              return WelcomeScreen();
            }
          }),
      routes: {
        // '/homescreen': (context) => const HomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/profile': (context) => UserProfileScreen(),
        '/main': (context) => MainScreen(),
        '/categories': (context) => CategoriesScreen(),
      },
    );
  }
}
