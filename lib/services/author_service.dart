import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class AuthorService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _authorCollection =
      _database.collection('authors');
  static final _storage = FirebaseStorage.instance;

  static Future<void> addNewAuthor(Author author) async {
    DateTime timeNow = DateTime.now();
    String authorId = '${author.authorName}-${timeNow.toString()}';
    Map<String, dynamic> newAuthor = {  
      'authorId': authorId,
      'authorName': author.authorName,
      'authorDescription': author.authorDescription,
      'authorProfileUrl': author.authorProfileUrl,
      'authorDataCreated': timeNow,
    };
    await _authorCollection.doc(newAuthor['authorId']).set(newAuthor);
  }

  static Future<void> updateAuthor(Author author) async {
    Map<String, dynamic> updatedAuthor = {
      'authorName': author.authorName,
      'authorDescription': author.authorDescription,
      'authorProfileUrl': author.authorProfileUrl,
      'authorDataCreated': author.authorDataCreated,
      'idBooks': author.idBooks      
    };
    await _authorCollection.doc(author.authorId).update(updatedAuthor);
  }

  static Future<String?> uploadImage(XFile imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('author-pictures/$fileName');

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