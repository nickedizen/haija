import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/models/review.dart';
import 'package:final_project_haija/services/author_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:rxdart/rxdart.dart';

class BooksService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _booksCollection =
      _database.collection('books');
  static final CollectionReference _authorCollection = _database.collection('authors');
  static final CollectionReference _genreCollection = _database.collection('genres');
  static final CollectionReference _userCollection = _database.collection('app-users');
  static final _storage = FirebaseStorage.instance;

static Future<void> addNewBook(Books book, BuildContext context) async {
  try {
    // Membuat ID buku berdasarkan title, author, dan tahun publishedDate
    String idBook = '${book.title}-${book.author}-${book.publishedDate.year}';

    // Konversi nilai yang nullable ke format yang sesuai
    double rating = book.rating ?? 0.0;
    List<String> genres = book.genre ?? [];
    String imageAsset = book.imageAsset ?? '';
    List<String> idOfUsersLikeThisBook = book.idOfUsersLikeThisBook ?? [];

    // Membuat map dari data buku
    Map<String, dynamic> newBook = {
      'idBook': idBook,
      'title': book.title,
      'lowercaseTitle': book.title.toLowerCase(),
      'author': book.author,
      'publishedDate': book.publishedDate,
      'rating': rating,
      'description': book.description,
      'genre': genres,
      'imageAsset': imageAsset,
      'reviews': [],
      'idOfUsersLikeThisBook': idOfUsersLikeThisBook
    };

    // Mengecek apakah buku sudah ada di Firestore
    final snapshot = await _booksCollection.doc(idBook).get();
    if (snapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book ${newBook['title']} already exists!'),
      ));
    } else {
      // Menyimpan data buku ke Firestore
      await _booksCollection.doc(idBook).set(newBook);

      // Memperbarui data penulis jika ada
      if (book.author.isNotEmpty) {
        for (var authorId in book.author) {
          _authorCollection.doc(authorId).update({
            'idBooks': FieldValue.arrayUnion([idBook])
          });
        }
      }

      // Memperbarui data genre jika ada
      if (genres.isNotEmpty) {
        for (var genreId in genres) {
          _genreCollection.doc(genreId).update({
            'idBooks': FieldValue.arrayUnion([idBook])
          });
        }
      }

      // Menutup layar dan menampilkan pesan berhasil
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book ${newBook['title']} has successfully been added.'),
      ));
    }
  } catch (e) {
    // Menampilkan pesan error
    print('Failed to add new book: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to add new book: $e'),
    ));
  }
}


  static Future<void> updateBook(Books book, BuildContext context) async {
    String idBook = '';
    if (book.idBook == null) {
      idBook = '${book.title}-${book.author}-${book.publishedDate.year}';
    } else {
      idBook = book.idBook!;
    }

    List<Map<String, dynamic>> reviews = book.reviews != null
        ? book.reviews!.map((review) => review.toDocument()).toList()
        : [];

    Map<String, dynamic> updatedBook = {
      'idBook': idBook,
      'title': book.title,
      'lowercaseTitle': book.title.toLowerCase(),
      'author': book.author,
      'publishedDate': book.publishedDate,
      'rating': book.rating,
      'description': book.description,
      'genre': book.genre,
      'imageAsset': book.imageAsset,
      'reviews': reviews,
      'idOfUsersLikeThisBook': book.idOfUsersLikeThisBook
    };
      await _booksCollection.doc(idBook).update(updatedBook);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book ${updatedBook['title']} has successfully been added.')
        )
      );
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
    return snapshot.docs.map((doc) => Books.fromDocument(doc)).toList();
  });
}

static Stream<List<Books>> getUserFavoriteBooksStream(String userId) {
  return _userCollection.snapshots().asyncMap((snapshot) async {
    DocumentSnapshot snapshot = await  _userCollection.doc(userId).get();
    var listFavoriteBookIdsDynamic = snapshot.get('favoriteBooks'); 
    if (listFavoriteBookIdsDynamic == null || listFavoriteBookIdsDynamic.isEmpty) {
      return []; // Return an empty list if favoriteBooks is null or empty
    }
    List<String> listFavoriteBookIds = List<String>.from(listFavoriteBookIdsDynamic.cast<String>());

    QuerySnapshot booksSnapshot = await _booksCollection.where(FieldPath.documentId, whereIn: listFavoriteBookIds).get();

    return booksSnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Books(
        idBook: data['idBook'],
        title: data['title'],
        author: data['author'] != null ? List<String>.from(data['author']) : [],
        publishedDate: (data['publishedDate'] as Timestamp).toDate(),
        rating: data['rating'] != null ? data['rating'] as double : null,
        description: data['description'],
        genre: data['genre'] != null ? List<String>.from(data['genre']) : [],
        imageAsset: data['imageAsset'],
        reviews: data['reviews'] != null ? (data['reviews'] as List<dynamic>).cast<Review>() : [],
        idOfUsersLikeThisBook: data['idOfUsersLikeThisBook'] != null ? List<String>.from(data['idOfUsersLikeThisBook']) : [],
      );
    }).toList();
  });
}


  static Future<Books> getSpecificBooks(String idBook) async {
    var snapshot = await _booksCollection.doc(idBook).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Books(
      title: data['title'],
      author: data['author'] != null ? (data['author'] as List<dynamic>).cast<String>() : [],
      publishedDate: (data['publishedDate'] as Timestamp).toDate(),
      rating: data['rating'] != null ? data['rating'] as double : null,
      description: data['description'],
      genre: data['genre'] != null ? (data['genre'] as List<dynamic>).cast<String>() : [],
      imageAsset: data['imageAsset'],
      reviews: data['reviews'] != null ? (data['reviews'] as List<dynamic>).cast<Review>() : [],
      idOfUsersLikeThisBook: data['idOfUsersLikeThisBook'] != null ? (data['idOfUsersLikeThisBook'] as List<dynamic>).cast<String>() : [],
    );
  }

  static Future<bool> checkifLiked(String idBook) async {
    var idUser = FirebaseAuth.instance.currentUser!.uid;
    Books book = await getSpecificBooks(idBook);
    if (book.idOfUsersLikeThisBook == null || book.idOfUsersLikeThisBook == 0) {
      return false;
    } else {
      if (book.idOfUsersLikeThisBook!.contains(idUser)) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Stream<List<Books>> getBooksByTitle(String title) {
  String searchKey = title.toLowerCase();
  String endKey = searchKey.substring(0, searchKey.length - 1) +
      String.fromCharCode(searchKey.codeUnitAt(searchKey.length - 1) + 1);

  return _booksCollection
      .where('lowercaseTitle', isGreaterThanOrEqualTo: searchKey)
      .where('lowercaseTitle', isLessThan: endKey)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => Books.fromDocument(doc)).toList();
  });
}
}