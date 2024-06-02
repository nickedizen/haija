import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/models/review.dart';

class Books {
  String? idBook;
  String title;
  List<String> author;
  final DateTime publishedDate;
  double? rating;
  String description;
  List<String> genre;
  String imageAsset;
  List<Review>? reviews;
  List<String>? idOfUsersLikeThisBook;

  Books({
    this.idBook,
    required this.title,
    required this.author,
    required this.publishedDate,
    this.rating,
    required this.description,
    required this.genre,
    required this.imageAsset,
    this.reviews,
    this.idOfUsersLikeThisBook
  });

  factory Books.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Books(
      idBook: data['idBook'],
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
      'idBook': idBook,
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