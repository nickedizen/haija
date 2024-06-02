import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/genre.dart';
import 'package:flutter/material.dart';

class GenreService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _genreCollection =
      _database.collection('genres');

  static Future<void> addNewGenre(Genre genre, BuildContext context) async {
    Map<String, dynamic> newGenre = {
      'genreName': genre.genreName,
      'idBooks': null
    };
    final snapshot = await _genreCollection.doc(newGenre['genreName']).get();
    if (snapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Genre ${newGenre['genreName']} is already exist!')));
    } else {
      await _genreCollection.doc(newGenre['genreName']).set(newGenre);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Genre ${newGenre['genreName']} has been added.')));
    }
  }
}
