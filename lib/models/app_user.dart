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

  AppUser({
    this.userId,
    this.status = 'user',
    required this.username,
    this.profilePicture,
    this.profileBio,
    this.latitude,
    this.longitude,
    this.favoriteBooks
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppUser(
      userId: data['userId'],
      status: data['status'],
      username: data['username'],
      profilePicture: data['profilePicture'],
      profileBio: data['profileBio'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      favoriteBooks: data['favoriteBooks'],
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
    };
  }
}
