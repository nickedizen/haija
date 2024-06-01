import 'package:final_project_haija/data/book_data.dart';
import 'package:final_project_haija/models/book.dart';
import 'package:final_project_haija/screens/author_edit_screen.dart';
import 'package:final_project_haija/screens/book_edit_screen.dart';
import 'package:final_project_haija/screens/filtered_screen.dart';
import 'package:final_project_haija/screens/genre_create_screen.dart';
import 'package:final_project_haija/screens/search_screen.dart';
import 'package:final_project_haija/services/appuser_service.dart';
import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:final_project_haija/widgets/indented_list_view.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? currentUserStatus;
  int currentPageIndex = 0;
  List<Book> latestBooks = bookList.where((item) =>
      item.publishedDate.isAfter(DateTime(2023)) &&
      item.publishedDate.isBefore(DateTime.now())).toList();

  List<Book> upcomingBooks = bookList.where((element) =>
      element.publishedDate.isAfter(DateTime.now())).toList();

  void _getUserStatus() async {
    final userStatus = await AppUserService.getUserStatus();
    setState(() {
      currentUserStatus = userStatus;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TODO: 1. Baris berisi ucapan Happy Reading dan tombol Search
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Happy Reading!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SearchScreen(searchQuery: '')));
                          },
                          icon: const Icon(Icons.search_outlined))
                    ],
                  ),
                ),

                if (currentUserStatus == 'admin')
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BookEditScreen()));
                            },
                            child: const Text('Create New Book Data')
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuthorEditScreen()));                          
                            },
                            child: const Text('Create New Author Data')
                          ),
                        ],
                      ),
                      ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GenreCreateScreen()));
                            },
                            child: const Text('Create New Genre Data')
                          ),
                    ],
                  ),

                // TODO: 2. List All Books
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          'All Books',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FilteredScreen(genre: 'All Books', list: bookList)));
                          },
                          child: const Text('see more')
                      )
                    ],
                  ),
                ),
                IndentedListView(itemList: bookList, indent: 15),

                const SizedBox(height: 25),

                // TODO: 3. List Latest Books
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Books',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FilteredScreen(genre: 'Latest Books', list: latestBooks)));
                          },
                          child: const Text('see more')
                      )
                    ],
                  ),
                ),
                IndentedListView(itemList: latestBooks, indent: 15),

                const SizedBox(height: 25),

                // TODO: 4. Upcoming All Books
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upcoming Books',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FilteredScreen(genre: 'Upcoming Books', list: upcomingBooks)));
                          },
                          child: const Text('see more')
                      )
                    ],
                  ),
                ),
                IndentedListView(itemList: upcomingBooks, indent: 15)
              ],
            ),
          ),
        ),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: 0)
    );
  }
}
