import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/services/books_service.dart';
import 'package:flutter/material.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/widgets/new_indented_list.dart';

class AuthorDetailScreen extends StatelessWidget {
  final String authorId;

  const AuthorDetailScreen({Key? key, required this.authorId}) : super(key: key);

  Future<List<Books>> _getBooksByAuthor(List<String>? idBooks) async {
    if (idBooks == null || idBooks.isEmpty) {
      return [];
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where(FieldPath.documentId, whereIn: idBooks)
        .get();

    return querySnapshot.docs.map((doc) => Books.fromDocument(doc)).toList();
  }

  Future<String?> getAuthorIdByName(String authorName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('authors')
        .where('authorName', isEqualTo: authorName)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Details'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('authors').doc(authorId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('Author not found.'));
              }

              Author author = Author.fromDocument(snapshot.data!);

              return FutureBuilder<List<Books>>(
                future: _getBooksByAuthor(author.idBooks),
                builder: (context, booksSnapshot) {
                  if (booksSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (booksSnapshot.hasError) {
                    return Center(child: Text('Error: ${booksSnapshot.error}'));
                  }

                  List<Books> books = booksSnapshot.data ?? [];

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (author.authorProfileUrl != null)
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(author.authorProfileUrl!),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          author.authorName,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        if (author.authorDescription != null)
                          Text(
                            author.authorDescription!,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 16),
                        const Text(
                          'Books by this Author:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        NewIndentedListView(
                          function: (BooksService.getBooksByAuthor(authorId)),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
