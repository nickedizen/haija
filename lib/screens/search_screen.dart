import 'package:final_project_haija/data/book_data.dart';
import 'package:final_project_haija/models/book.dart';
import 'package:final_project_haija/widgets/book_card.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Book> _filteredBooks = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.text = widget.searchQuery;
    // _filterBooks(widget.searchQuery);
    super.initState();
  }

  // void _filterBooks(String search) {
  //   List<Book> filtered = [];
  //   filtered.addAll(bookList.where((book) {
  //     return book.title.toLowerCase().contains(search.toLowerCase()) ||
  //     book.author.toLowerCase().contains(search.toLowerCase());
  //   }));
  //   setState(() {
  //     _searchQuery = search;
  //     _filteredBooks.clear();
  //     _filteredBooks.addAll(filtered);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                      TextField(

                        controller: _searchController,
                        // onChanged: _filterBooks,
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
                      ),

                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),

                        padding: const EdgeInsets.all(8),
                        itemCount: _filteredBooks.length,
                        itemBuilder: (context, index) {
                          Book book = _filteredBooks[index];
                          return BookCard(book: book);
                        },
                      ),
                    ),
                  ],
                )
            ),
          )
    );
  }
}
