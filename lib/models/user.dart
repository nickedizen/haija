import 'package:final_project_haija/models/book.dart';

class AppUser {
  String id;
  String status = 'user';
  String username;
  String? profilePicture;
  String? profileBio;
  double? latitude;
  double? longitude;
  List<Book>? favoriteBooks;

  AppUser({
    required this.id,
    required this.username
  });
}