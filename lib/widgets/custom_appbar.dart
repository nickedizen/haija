import 'package:final_project_haija/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/services/books_service.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget { 
  final TextEditingController _searchController = TextEditingController(); // Modify the function to return a list of filtered books

  CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true, // Automatically show the back button
      title: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: TextField(
          style: const TextStyle(height: 0.1),
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 0.8),
            ),
            hintText: 'Search',
            prefixIcon: const Icon(
              Icons.search,
              size: 30.0,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
          onSubmitted: (String query) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SearchScreen(query: _searchController.text))
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
