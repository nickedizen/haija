import 'package:final_project_haija/screens/search_screen.dart';
import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:final_project_haija/widgets/shadow_above_image_button.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // TODO 1 : Membuat search bar
                TextField(
                  onSubmitted: (value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen(searchQuery: _searchQuery)
                  ),),
                  controller: _searchController,
                  onChanged: _typeQuery,
                  decoration: InputDecoration(
                    hintText: 'Search title/author',
                    prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    )
                    ),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                  ),

                const SizedBox(height: 30),

                // TODO 2: Membuat tulisan 'Categories'
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                 const Row(
                  children: [
                    // TODO 3: Membuat tombol non-fiction
                    ShadowAboveImageButton(text: 'Nonfiction', imageAsset: 'images/nonfiction.jpg'),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 4: Membuat tombol fiction
                    ShadowAboveImageButton(text: 'Fiction', imageAsset: 'images/fiction.png')
                  ],
                ),

                const SizedBox(height: 20),

                const Row(
                  children: [
                    // TODO 5: Membuat tombol fantasy
                    ShadowAboveImageButton(text: 'Fantasy', imageAsset: 'images/fantasy.jpeg'),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 6: Membuat tombol young adult
                    ShadowAboveImageButton(text: 'Young Adult', imageAsset: 'images/youngadult.jpg'),
                  ],
                ),

                const SizedBox(height: 20),

                const Row(
                  children: [
                    // TODO 7: Membuat tombol crime
                    ShadowAboveImageButton(text: 'Crime', imageAsset: 'images/crime.jpg'),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 8: Membuat tombol horror
                    ShadowAboveImageButton(text: 'Horror', imageAsset: 'images/horror.jpg'),
                  ],
                ),

                const SizedBox(height: 20),

                const Row(
                  children: [
                    // TODO 9: Membuat tombol sci-fi
                    ShadowAboveImageButton(text: 'Science Fiction', imageAsset: 'images/scifi.jpg'),

                    SizedBox(
                      height: 100,
                      width: 20,
                    ),

                    // TODO 10: Membuat tombol drama
                    ShadowAboveImageButton(text: 'Romance', imageAsset: 'images/drama.jpg'),
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
