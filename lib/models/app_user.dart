import 'package:final_project_haija/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String status;
  String username;
  String? profilePicture;
  String? profileBio;
  double? latitude;
  double? longitude;
  List<Book>? favoriteBooks;

  AppUser({
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
      status: data['user'],
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
