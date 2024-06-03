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
  static final CollectionReference _booksCollection =
      _database.collection('books');
  static final _storage = FirebaseStorage.instance;

  static Future<void> addNewAppUser(AppUser appUser) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> newAppUser = {
      'userId': userId,
      'status': appUser.status,
      'username': appUser.username,
      'profilePicture': appUser.profilePicture,
      'profileBio': appUser.profileBio,
      'latitude': appUser.latitude,
      'longitude': appUser.longitude,
      'favoriteBooks': appUser.favoriteBooks,
      'requestFriendTo': appUser.requestFriendTo,
      'requestFriendFrom': appUser.requestFriendFrom,
      'friendsId': appUser.friendsId
    };
    await _appUserCollection.doc(userId).set(newAppUser);
  }

  static Future<void> updateAppUser(AppUser appUser) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> updatedAppUser = {
      'userId': appUser.userId,
      'status': appUser.status,
      'username': appUser.username,
      'profilePicture': appUser.profilePicture,
      'profileBio': appUser.profileBio,
      'latitude': appUser.latitude,
      'longitude': appUser.longitude,
      'favoriteBooks': appUser.favoriteBooks,
      'requestFriendTo': appUser.requestFriendTo,
      'requestFriendFrom': appUser.requestFriendFrom,
      'friendsId': appUser.friendsId
    };
    await _appUserCollection.doc(userId).update(updatedAppUser);
  }

  static Future<AppUser?> getAppUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = _appUserCollection.doc(userId);
    try {
      final userSnapshot = await userDoc.get();
      if (userSnapshot.exists) {
        print("User data fetched.");
        return AppUser.fromDocument(userSnapshot);
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
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

  static Future<String> getUserStatus() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = _appUserCollection.doc(userId);
    final userSnapshot = await userDoc.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    return userData['status'];
  }

  static Stream<List<AppUser>> getUserLikeThisBookStream(String bookId) {
    return _booksCollection.snapshots().asyncMap((snapshot) async {
      DocumentSnapshot snapshot = await _booksCollection.doc(bookId).get();
      var userListDynamic = snapshot.get('idOfUsersLikeThisBook');
      if (userListDynamic == null || userListDynamic.isEmpty) {
        return [];
      }
      List<String> userList = List<String>.from(userListDynamic.cast<String>());
      QuerySnapshot usersSnapshot = await _appUserCollection
      .where(FieldPath.documentId, whereIn: userList)
      .get();

      return usersSnapshot.docs.map((doc) => AppUser.fromDocument(doc)).toList();
    });
  }

  static Future<void> addOtherUser(String otherUserId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = _appUserCollection.doc(userId);
    _appUserCollection.doc(otherUserId).update({
      'requestFriendFrom': FieldValue.arrayUnion([userId])
    });
    userDoc.update({
      'requestFriendTo': FieldValue.arrayUnion([otherUserId])
    });
  }

  static Future<void> confirmOtherUserAsFriend(String otherUserId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = _appUserCollection.doc(userId);
    _appUserCollection.doc(otherUserId).update({
      'requestFriendTo': FieldValue.arrayRemove([userId])
    });
    userDoc.update({
      'requestFriendFrom': FieldValue.arrayRemove([otherUserId])
    });
    _appUserCollection.doc(otherUserId).update({
      'friendsId': FieldValue.arrayUnion([userId])
    });
    userDoc.update({
      'friendsId': FieldValue.arrayUnion([otherUserId])
    });
  }

  static Future<void> denyOtherUserAsFriend(String otherUserId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = _appUserCollection.doc(userId);
    _appUserCollection.doc(otherUserId).update({
      'requestFriendTo': FieldValue.arrayRemove([userId])
    });
    userDoc.update({
      'requestFriendFromg': FieldValue.arrayRemove([otherUserId])
    });
  }

  static Future<void> removeOtherUserFromFriend(String otherUserId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = _appUserCollection.doc(userId);
    _appUserCollection.doc(otherUserId).update({
      'friendsId': FieldValue.arrayRemove([userId])
    });
    userDoc.update({
      'friendsId': FieldValue.arrayRemove([otherUserId])
    });
  }
}
