import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/models/review.dart';
import 'package:final_project_haija/services/author_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class BooksService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _booksCollection =
      _database.collection('books');
  static final CollectionReference _authorCollection =
      _database.collection('authors');
  static final CollectionReference _genreCollection =
      _database.collection('genres');
  static final _storage = FirebaseStorage.instance;

  static Future<void> addNewBook(Books book, BuildContext context) async {
    Map<String, dynamic> newBook = {
      'title': book.title,
      'lowercaseTitle': book.title.toLowerCase(),
      'author': book.author,
      'publishedDate': book.publishedDate,
      'rating': book.rating,
      'description': book.description,
      'genre': book.genre,
      'imageAsset': book.imageAsset,
      'reviews': book.reviews,
      'idOfUsersLikeThisBook': book.idOfUsersLikeThisBook
    };

    final snapshot = await _booksCollection
        .doc('${book.title}-${book.author}-${book.publishedDate.year}')
        .get();
    if (snapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book ${newBook['title']} is already exist!')));
    } else {
      await _booksCollection
          .doc('${book.title}-${book.author}-${book.publishedDate.year}')
          .set(newBook);
      if (book.author.isNotEmpty) {
        for (var authorId in book.author) {
          _authorCollection.doc(authorId).update({
            'idBooks': FieldValue.arrayUnion(
                ['${book.title}-${book.author}-${book.publishedDate.year}'])
          });
        }
      }
      if (book.genre.isNotEmpty) {
        for (var genreId in book.genre) {
          _genreCollection.doc(genreId).update({
            'idBooks': FieldValue.arrayUnion(
                ['${book.title}-${book.author}-${book.publishedDate.year}'])
          });
        }
      }
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Book ${newBook['title']} has successfully been added.')));
    }
  }

  static Future<void> editBookk(Books book, BuildContext context) async {
    Map<String, dynamic> newBook = {
      'title': book.title,
      'lowercaseTitle': book.title.toLowerCase(),
      'author': book.author,
      'publishedDate': book.publishedDate,
      'rating': book.rating,
      'description': book.description,
      'genre': book.genre,
      'imageAsset': book.imageAsset,
      'reviews': book.reviews,
      'idOfUsersLikeThisBook': book.idOfUsersLikeThisBook
    };

    final snapshot = await _booksCollection
        .doc('${book.title}-${book.author}-${book.publishedDate.year}')
        .update(newBook);
  }

  static Future<String?> uploadImage(XFile imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('book-covers/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(await imageFile.readAsBytes());
      } else {
        uploadTask = ref.putFile(File(imageFile.path));
      }

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  static Stream<List<Books>> getBooksList() {
    return _booksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Books(
          title: data['title'],
          author: data['author'] != null
              ? (data['author'] as List<dynamic>).cast<String>()
              : [],
          publishedDate: (data['publishedDate'] as Timestamp).toDate(),
          rating: data['rating'] != null ? data['rating'] as double : null,
          description: data['description'],
          genre: data['genre'] != null
              ? (data['genre'] as List<dynamic>).cast<String>()
              : [],
          imageAsset: data['imageAsset'],
          reviews: data['reviews'] != null
              ? (data['reviews'] as List<dynamic>).cast<Review>()
              : [],
          idOfUsersLikeThisBook: data['idOfUsersLikeThisBook'] != null
              ? (data['idOfUsersLikeThisBook'] as List<dynamic>).cast<String>()
              : [],
        );
      }).toList();
    });
  }
}
