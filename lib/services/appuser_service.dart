import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/user.dart';

class AppUserService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _appUserCollection = _database.collection('app-users');

  static Future<void> addNewAppUser(AppUser appUser) async {
    Map<String, dynamic> newAppUser = {
      'id': appUser.id,
      'status': appUser.status,
      'username': appUser.username,
      'profilePicture': appUser.profilePicture,
      'profileBio': appUser.profileBio,
      'latitude': appUser.latitude,
      'longitude': appUser.longitude,
      'favoriteBooks': appUser.favoriteBooks,
    };
    await _appUserCollection.add(newAppUser);
  }
}