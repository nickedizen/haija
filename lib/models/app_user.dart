import 'package:final_project_haija/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? userId;
  String status;
  String username;
  String? profilePicture;
  String? profileBio;
  double? latitude;
  double? longitude;
  List<String>? favoriteBooks;
  List<String>? requestFriendTo;
  List<String>? requestFriendFrom;
  List<String>? friendsId;

  AppUser({
    this.userId,
    this.status = 'user',
    required this.username,
    this.profilePicture,
    this.profileBio,
    this.latitude,
    this.longitude,
    this.favoriteBooks,
    this.requestFriendTo,
    this.requestFriendFrom,
    this.friendsId
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppUser(
      userId: data['userId'],
      status: data['status'],
      username: data['username'],
      profilePicture: data['profilePicture'],
      profileBio: data['profileBio'],
      latitude: data['latitude'] != null ? data['latitude'] as double : null,
      longitude: data['longitude'] != null ? data['longitude'] as double : null,
      favoriteBooks: data['favoriteBooks'] != null ? List<String>.from(data['favoriteBooks']) : [],
      requestFriendTo: data['requestFriendTo']!= null ? List<String>.from(data['requestFriendTo']) : [],
      requestFriendFrom: data['requestFriendFrom']!= null ? List<String>.from(data['requestFriendFrom']) : [],
      friendsId: data['friendsId']!= null ? List<String>.from(data['friendsId']) : []
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'status': status,
      'username': username,
      'profilePicture': profilePicture,
      'profileBio': profileBio,
      'latitude': latitude,
      'longitude': longitude,
      'favoriteBooks': favoriteBooks,
      'requestFriendTo': requestFriendTo,
      'requestFriendFrom': requestFriendFrom,
      'friendsId': friendsId

    };
  }
}
