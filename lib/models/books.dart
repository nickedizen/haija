import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/models/review.dart';

class Books {
  String? idBook;
  String title;
  String? lowercaseTitle;
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
    this.lowercaseTitle,
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
      lowercaseTitle: data['lowercaseTitle'],
      author: data['author'] != null ? (data['author'] as List<dynamic>).cast<String>() : [],
      publishedDate: (data['publishedDate'] as Timestamp).toDate(),
      rating: data['rating'] != null ? (data['rating'] is int ? (data['rating'] as int).toDouble() : data['rating'] as double) : null,
      description: data['description'],
      genre: data['genre'] != null ? (data['genre'] as List<dynamic>).cast<String>() : [],
      imageAsset: data['imageAsset'],
      reviews: data['reviews'] != null ? (data['reviews'] as List<dynamic>).map((review) => Review.fromMap(review)).toList() : [],
      idOfUsersLikeThisBook: data['idOfUsersLikeThisBook'] != null ? (data['idOfUsersLikeThisBook'] as List<dynamic>).cast<String>() : [],
  );
}
  Map<String, dynamic> toDocument() {
    return {
      'idBook': idBook,
      'title': title,
      'lowercaseTitle': lowercaseTitle,
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