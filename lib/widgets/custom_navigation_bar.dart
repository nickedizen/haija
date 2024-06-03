import 'package:final_project_haija/screens/categories_screen.dart';
import 'package:final_project_haija/screens/main_screen.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  int selectedIndex;

  CustomNavigationBar({super.key, required this.selectedIndex});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.black,
      destinations: [
        NavigationDestination(
            icon: widget.selectedIndex == 0? const Icon(Icons.home, color: Colors.white) : const Icon(Icons.home, color: Colors.black),
            label: 'Home'),
        NavigationDestination(
            icon: widget.selectedIndex == 1? const Icon(Icons.category, color: Colors.white) : const Icon(Icons.category, color: Colors.black),
            label: 'Search'),
        NavigationDestination(
            icon: widget.selectedIndex == 2? const Icon(Icons.account_box, color: Colors.white) : const Icon(Icons.account_box, color: Colors.black),
            label: 'Account'),
      ],
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (index) {
        if(index == 0) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen())
          );
        }
        if(index == 1) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CategoriesScreen())
          );
        }
        if(index == 2) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserProfileScreen())
          );          
        }
      },
    );
  }
}
