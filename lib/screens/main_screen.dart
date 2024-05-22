import 'package:final_project_haijo/data/book_data.dart';
import 'package:final_project_haijo/models/book.dart';
import 'package:final_project_haijo/screens/filtered_screen.dart';
import 'package:final_project_haijo/screens/search_screen.dart';
import 'package:final_project_haijo/widgets/custom_navigation_bar.dart';
import 'package:final_project_haijo/widgets/indented_list_view.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  List<Book> latestBooks = bookList.where((item) =>
      item.publishedDate.isAfter(DateTime(2023)) &&
      item.publishedDate.isBefore(DateTime.now())).toList();

  List<Book> upcomingBooks = bookList.where((element) =>
      element.publishedDate.isAfter(DateTime.now())).toList();

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
