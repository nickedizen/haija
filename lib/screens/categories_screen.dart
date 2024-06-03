import 'package:final_project_haija/screens/search_screen.dart';
import 'package:final_project_haija/widgets/custom_appbar.dart';
import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:final_project_haija/widgets/shadow_above_image_button.dart';
import 'package:flutter/material.dart';

import 'genre_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  void _typeQuery(String search) {
    setState(() => _searchQuery = search);
  }

  void navigateToGenreScreen(String genre) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => GenreScreen(genre: genre),
  ));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SizedBox(height: 30),

                // TODO 2: Membuat tulisan 'Categories'
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Genres',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                 Row(
                  children: [
                    // TODO 3: Membuat tombol non-fiction
                    ShadowAboveImageButton(text: 'Nonfiction', 
                    imageAsset: 'images/nonfiction.jpg',
                    onTap: () => navigateToGenreScreen('Nonfiction'),),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 4: Membuat tombol fiction
                    ShadowAboveImageButton(text: 'Fiction', imageAsset: 'images/fiction.png',
                    onTap: () => navigateToGenreScreen('Fiction'),)
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    // TODO 5: Membuat tombol fantasy
                    ShadowAboveImageButton(text: 'Fantasy', imageAsset: 'images/fantasy.jpeg',
                    onTap: () => navigateToGenreScreen('Fantasy'),),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 6: Membuat tombol young adult
                    ShadowAboveImageButton(text: 'Young Adult', imageAsset: 'images/youngadult.jpg',
                    onTap: () => navigateToGenreScreen('Young Adult'),),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    // TODO 7: Membuat tombol crime
                    ShadowAboveImageButton(text: 'Crime', imageAsset: 'images/crime.jpg',
                    onTap: () => navigateToGenreScreen('Crime'),),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 8: Membuat tombol horror
                    ShadowAboveImageButton(text: 'Horror', imageAsset: 'images/horror.jpg',
                    onTap: () => navigateToGenreScreen('Horror'),),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    // TODO 9: Membuat tombol sci-fi
                    ShadowAboveImageButton(text: 'Science Fiction', imageAsset: 'images/scifi.jpg',
                    onTap: () => navigateToGenreScreen('Science Fiction'),),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 10: Membuat tombol drama
                    ShadowAboveImageButton(text: 'Romance', imageAsset: 'images/drama.jpg',
                    onTap: () => navigateToGenreScreen('Romance'),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: 1),
    );
  }
}
