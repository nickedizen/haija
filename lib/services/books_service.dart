import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class BooksService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _booksCollection =
      _database.collection('books');
  static final _storage = FirebaseStorage.instance;

  static Future<void> addNewBook(Books book, BuildContext context) async {
    Map<String, dynamic> newBook = {
      'title': book.title,
      'author': book.author,
      'publishedDate': book.publishedDate,
      'rating': book.rating,
      'description': book.description,
      'genre': book.genre,
      'imageAsset': book.imageAsset,
      'reviews': book.reviews,
      'idOfUsersLikeThisBook': book.idOfUsersLikeThisBook
    };
    final snapshot = await _booksCollection.doc('${book.title}-${book.author}-${book.publishedDate.year}').get();
    if (snapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book ${newBook['title']} is already exist!')
        )
      );
    } else {
      await _booksCollection.doc('${book.title}-${book.author}-${book.publishedDate.year}').set(newBook);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book ${newBook['title']} has successfully been added.')
        )
      );
    }
  }

  static Future<String?> uploadImage(XFile imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('profile-pictures/$fileName');

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
}