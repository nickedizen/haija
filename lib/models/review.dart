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

  factory Review.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
      idUser: data['idUser'], 
      rating: data['rating'], 
      comment: data['comment'],
      reviewDate: data['reviewDate']
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