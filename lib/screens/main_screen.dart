import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/data/book_data.dart';
import 'package:final_project_haija/models/book.dart';
import 'package:final_project_haija/screens/author_edit_screen.dart';
import 'package:final_project_haija/screens/book_edit_screen.dart';
import 'package:final_project_haija/screens/filtered_screen.dart';
import 'package:final_project_haija/screens/genre_create_screen.dart';
import 'package:final_project_haija/screens/search_screen.dart';
import 'package:final_project_haija/screens/sign_in_screen.dart';
import 'package:final_project_haija/services/appuser_service.dart';
import 'package:final_project_haija/services/books_service.dart';
import 'package:final_project_haija/widgets/custom_appbar.dart';
import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:final_project_haija/widgets/indented_list_view.dart';
import 'package:final_project_haija/widgets/new_indented_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/books.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? currentUserStatus;
  List<Books> _books = [];
  List<Books> _filteredBooks = [];

  List<Book> latestBooks = bookList
      .where((item) =>
          item.publishedDate.isAfter(DateTime(2023)) &&
          item.publishedDate.isBefore(DateTime.now()))
      .toList();

  List<Book> upcomingBooks = bookList
      .where((element) => element.publishedDate.isAfter(DateTime.now()))
      .toList();

  void _getUserStatus() async {
    final userStatus = await AppUserService.getUserStatus();
    setState(() {
      currentUserStatus = userStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserStatus();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();

    setState(() {
      _books = querySnapshot.docs.map((doc) => Books.fromDocument(doc)).toList();
      _filteredBooks = _books;
    });
  }

  void _filterBooks(String query) {
    final filteredBooks = _books.where((book) {
      final titleLower = book.title.toLowerCase();
      final authorLower = book.author.join(' ').toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) || authorLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredBooks = filteredBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (currentUserStatus == 'admin')
                Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BookEditScreen()));
                          },
                          child: const Text('Create New Book Data'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AuthorEditScreen()));
                          },
                          child: const Text('Create New Author Data'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GenreCreateScreen()));
                      },
                      child: const Text('Create New Genre Data'),
                    ),
                  ],
                ),

              // All Books Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Books',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => FilteredScreen(genre: 'All Books', list: bookList)));
                      },
                      child: const Text('see more'),
                    ),
                  ],
                ),
              ),
              NewIndentedListView(
                function: BooksService.getBooksList(),
              ),

              const SizedBox(height: 25),

              // Latest Books Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest Books',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => FilteredScreen(genre: 'Latest Books', list: latestBooks)));
                      },
                      child: const Text('see more'),
                    ),
                  ],
                ),
              ),
              IndentedListView(itemList: latestBooks, indent: 15),

              const SizedBox(height: 25),

              // Upcoming Books Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upcoming Books',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => FilteredScreen(genre: 'Upcoming Books', list: upcomingBooks)));
                      },
                      child: const Text('see more'),
                    ),
                  ],
                ),
              ),
              IndentedListView(itemList: upcomingBooks, indent: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: 0),
    );
  }
}
