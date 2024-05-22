import 'package:final_project_haijo/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/book_data.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Book> favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteBooks();
  }

  Future<void> _loadFavoriteBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorite_books') ?? [];
    setState(() {
      // favoriteBooks = favorites;
      favoriteBooks = favorites.map((id) {
        // Assuming bookList is a list of all available books
        return bookList.firstWhere((book) => book.title == id);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Books'),
        backgroundColor: Colors.black,
      ),
      body: favoriteBooks.isEmpty
          ? Center(
              child: Text('No favorite books yet.'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                Book book = favoriteBooks[index];
                return BookCard(book: book);
              },
            ),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: 2),
);
}
}
