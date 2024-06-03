import 'package:flutter/material.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/services/books_service.dart';

import '../widgets/books_card.dart';

class GenreScreen extends StatelessWidget {
  final String genre;

  const GenreScreen({required this.genre, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(genre),
      ),
      body: StreamBuilder<List<Books>>(
        stream: BooksService.getBooksByGenre(genre),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books available for this genre.'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return BooksCard(book: book);
              },
            );
          }
        },
      ),
    );
  }
}
