import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project_haija/models/app_user.dart';

class AppUserService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _appUserCollection = _database.collection('app-users');
  static final userId = FirebaseAuth.instance.currentUser!.uid;


  static Future<void> addNewAppUser({required String id, required AppUser appUser}) async {
    Map<String, dynamic> newAppUser = {
      'status': appUser.status,
      'username': appUser.username,
      'profilePicture': appUser.profilePicture,
      'profileBio': appUser.profileBio,
      'latitude': appUser.latitude,
      'longitude': appUser.longitude,
      'favoriteBooks': appUser.favoriteBooks,
    };
    await _appUserCollection.doc(id).set(newAppUser);
  }

  static Future<void> updateAppUser(String id, AppUser appUser) async {
    Map<String, dynamic> updatedAppUser = {
      'status': appUser.status,
      'username': appUser.username,
      'profilePicture': appUser.profilePicture,
      'profileBio': appUser.profileBio,
      'latitude': appUser.latitude,
      'longitude': appUser.longitude,
      'favoriteBooks': appUser.favoriteBooks,
    };
    await _appUserCollection.doc(id).update(updatedAppUser);
  }


}