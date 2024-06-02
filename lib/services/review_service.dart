import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/review.dart';



class ReviewService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _reviewCollection = _database.collection('reviews');


  static Future<void> addNewReview(String userId, Review review) async {
    Map<String, dynamic> newReview = review.toDocument();

    try {
      await _reviewCollection.doc(userId).set(newReview);
      print('Review has been added.');
    } catch (e) {
      print('Failed to add review: $e');
    }
  }

  static Future<void> addNewReviewToBook(String bookId, Review review, CollectionReference booksCollection) async {
  Map<String, dynamic> newReview = review.toDocument();

  try {
    await _reviewCollection.doc(review.idUser).set(newReview);
    print('Review has been added.');

    // Tambahkan review ke buku yang sesuai
    await booksCollection.doc(bookId).update({
      'reviews': FieldValue.arrayUnion([review.toDocument()])
    });
    print('Review has been added to book.');
  } catch (e) {
    print('Failed to add review to book: $e');
  }
}


  static Future<List<Review>> fetchReviews() async {
    try {
      QuerySnapshot snapshot = await _reviewCollection.get();
      return snapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
    } catch (e) {
      print('Failed to fetch reviews: $e');
      return [];
    }
  }

  static Future<Review?> getReviewById(String id) async {
    try {
      DocumentSnapshot doc = await _reviewCollection.doc(id).get();
      if (doc.exists) {
        return Review.fromDocument(doc);
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get review: $e');
      return null;
    }
  }

  static Future<void> updateReview(String id, Review review) async {
    Map<String, dynamic> updatedReview = review.toDocument();

    try {
      await _reviewCollection.doc(id).update(updatedReview);
      print('Review has been updated.');
    } catch (e) {
      print('Failed to update review: $e');
    }
  }

  static Future<void> deleteReview(String id) async {
    try {
      await _reviewCollection.doc(id).delete();
      print('Review has been deleted.');
    } catch (e) {
      print('Failed to delete review: $e');
    }
  }
}