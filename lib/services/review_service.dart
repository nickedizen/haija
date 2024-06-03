import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/models/review.dart';



class ReviewService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _booksCollection = _database.collection('books');

  static Future<void> addNewReviewToBook(String bookId, Review review) async {
  double reviewRating = review.rating;
  DocumentReference bookDocument = _booksCollection.doc(bookId);
  Map<String, dynamic> newReview = review.toDocument();
  try {
    await bookDocument.update({
      'reviews': FieldValue.arrayUnion([newReview])
    });
    print('Review has been added to book.');


    DocumentSnapshot currentBookSnapshot = await bookDocument.get();
    Books currentBook = Books.fromDocument(currentBookSnapshot);
    double currentBookRating = currentBook.rating ?? 0;
    int currentBookReviewTotal = currentBook.reviews != null ? currentBook.reviews!.length : 0;
    print(currentBookReviewTotal);

    currentBookRating = currentBookRating + reviewRating;
    double finalBookRating = currentBookRating / currentBookReviewTotal;

    await bookDocument.update({'rating': finalBookRating});
    print('Rating has been updated.');
  } catch (e) {
    print('Failed to add review to book: $e');
  }
}
    static Stream<List<Review>> getReviewsForBook(String bookId) {
    return _booksCollection.doc(bookId).snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data['reviews'] != null) {
          List<dynamic> reviewsData = data['reviews'];
          return reviewsData.map((reviewData) {
            return Review.fromMap(reviewData as Map<String, dynamic>);
          }).toList();
        }
      }
      return [];
    });
  }

    static Future<Review?> getUserReviewForBook(String bookId, String userId) async {
    DocumentSnapshot bookDoc = await _booksCollection.doc(bookId).get();
    List<dynamic> reviews = bookDoc.get('reviews') ?? [];
    for (var review in reviews) {
      if (review['idUser'] == userId) {
        return Review.fromDocument(review);
      }
    }
    return null;
  }

  static Future<void> editReviewForBook(String bookId, Review review) async {
    DocumentReference bookDocument = _booksCollection.doc(bookId);
    try {
      DocumentSnapshot currentBookSnapshot = await bookDocument.get();
      List<dynamic> reviews = currentBookSnapshot.get('reviews') ?? [];
      reviews = reviews.map((r) {
        if (r['idUser'] == review.idUser) {
          return review.toDocument();
        }
        return r;
      }).toList();

      await bookDocument.update({'reviews': reviews});
      print('Review has been edited.');
    } catch (e) {
      print('Failed to edit review: $e');
    }
  }
  
  // static Future<List<Review>> fetchReviews() async {
  //   try {
  //     QuerySnapshot snapshot = await _reviewCollection.get();
  //     return snapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
  //   } catch (e) {
  //     print('Failed to fetch reviews: $e');
  //     return [];
  //   }
  // }

  // static Future<Review?> getReviewById(String id) async {
  //   try {
  //     DocumentSnapshot doc = await _reviewCollection.doc(id).get();
  //     if (doc.exists) {
  //       return Review.fromDocument(doc);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Failed to get review: $e');
  //     return null;
  //   }
  // }

  // static Future<void> updateReview(String id, Review review) async {
  //   Map<String, dynamic> updatedReview = review.toDocument();

  //   try {
  //     await _reviewCollection.doc(id).update(updatedReview);
  //     print('Review has been updated.');
  //   } catch (e) {
  //     print('Failed to update review: $e');
  //   }
  // }

  // static Future<void> deleteReview(String id) async {
  //   try {
  //     await _reviewCollection.doc(id).delete();
  //     print('Review has been deleted.');
  //   } catch (e) {
  //     print('Failed to delete review: $e');
  //   }
  // }
}