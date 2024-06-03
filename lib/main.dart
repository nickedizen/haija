import 'dart:io';

import 'package:final_project_haija/screens/ratingreview_screen.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:final_project_haija/screens/pengaturan_screen.dart';
import 'package:final_project_haija/screens/ratingreview_screen.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:final_project_haija/screens/categories_screen.dart';
import 'package:final_project_haija/screens/main_screen.dart';
import 'package:final_project_haija/screens/sign_in_screen.dart';
import 'package:final_project_haija/screens/sign_up_screen.dart';
import 'package:final_project_haija/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:final_project_haija/screens/themeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await FlutterConfig.loadEnvVariables();
  }
  await GetStorage.init(); // Initialize GetStorage
  final themeProvider = Themeprovider();
  await themeProvider.getTheme(); // Load the saved theme
  runApp(
    ChangeNotifierProvider.value( // Use ChangeNotifierProvider.value to provide an existing instance
      value: themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Themeprovider>(
      builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Haija Library',
          theme: theme.isDark ? ThemeData.dark() : ThemeData.light(),
          home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainScreen();
              } else {
                return WelcomeScreen();
              }
            },
          ),
          routes: {
            '/signin': (context) => SignInScreen(),
            '/welcome': (context) => WelcomeScreen(),
            '/signup': (context) => SignUpScreen(),
            '/profile': (context) => UserProfileScreen(),
            '/main': (context) => MainScreen(),
            '/categories': (context) => CategoriesScreen(),
            '/pengaturan': (context) => PengaturanScreen(),
          },
        );
      },
    );
  }
}
