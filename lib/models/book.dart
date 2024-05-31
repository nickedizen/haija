import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/models/review.dart';

class Book {
  final String title;
  final List<Author> author;
  final DateTime publishedDate;
  final double? rating;
  final String description;
  final List<String> genre;
  final String imageAsset;
  List<Review>? reviews;
  List<String>? idOfUsersLikeThisBook;

  Book({
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.rating,
    required this.description,
    required this.genre,
    required this.imageAsset,
    this.reviews,
    this.idOfUsersLikeThisBook
  });

  factory Book.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Book(
      title: data['title'],
      author: data['author'],
      publishedDate: data['publishedDate'],
      rating: data['rating'],
      description: data['description'],
      genre: data['genre'],
      imageAsset: data['imageAsset'],
      reviews: data['reviews'],
      idOfUsersLikeThisBook: data['idOfUsersLikeThisBook']
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'rating': rating,
      'description': description,
      'genre': genre,
      'imageAsset': imageAsset,
      'reviews': reviews,
      'idOfUsersLikeThisBook': idOfUsersLikeThisBook
    };
  }
}