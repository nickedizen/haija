import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String idUser;
  double rating;
  String? comment;
  DateTime reviewDate;

  Review({
    required this.idUser,
    required this.rating,
    this.comment,
    required this.reviewDate,
  });

  factory Review.fromDocument(Map<String, dynamic> data) {
    return Review(
      idUser: data['idUser'],
      rating: (data['rating'] as num).toDouble(), // Pastikan tipe data double
      comment: data['comment'],
      reviewDate: (data['reviewDate'] as Timestamp).toDate(),
    );
  }

  factory Review.fromMap(Map<String, dynamic> data) {
    return Review(
      idUser: data['idUser'], 
      rating: data['rating'].toDouble(), 
      comment: data['comment'],
      reviewDate: (data['reviewDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'idUser': idUser,
      'rating': rating,
      'comment': comment,
      'reviewDate': reviewDate
    };
  }
}