import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project_haija/models/app_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AppUserService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _appUserCollection =
      _database.collection('app-users');
  static final _storage = FirebaseStorage.instance;
  static final userId = FirebaseAuth.instance.currentUser!.uid;
  static final userDoc = _appUserCollection.doc(userId);

  static Future<void> addNewAppUser(AppUser appUser) async {
    Map<String, dynamic> newAppUser = {
      'status': appUser.status,
      'username': appUser.username,
      'profilePicture': appUser.profilePicture,
      'profileBio': appUser.profileBio,
      'latitude': appUser.latitude,
      'longitude': appUser.longitude,
      'favoriteBooks': appUser.favoriteBooks,
    };
    await _appUserCollection.doc(userId).set(newAppUser);
  }

  static Future<void> updateAppUser(AppUser appUser) async {
    Map<String, dynamic> updatedAppUser = {
      'status': appUser.status,
      'username': appUser.username,
      'profilePicture': appUser.profilePicture,
      'profileBio': appUser.profileBio,
      'latitude': appUser.latitude,
      'longitude': appUser.longitude,
      'favoriteBooks': appUser.favoriteBooks,
    };
    await _appUserCollection.doc(userId).update(updatedAppUser);
  }

  static Future<AppUser> getAppUserData() async {
    final userSnapshot = await userDoc.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    return AppUser(
        status: userData['status'],
        username: userData['username'],
        profilePicture: userData['profilePicture'],
        profileBio: userData['profileBio'],
        latitude: userData['latitude'],
        longitude: userData['longitude'],
        favoriteBooks: userData['favoriteBooks']);
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