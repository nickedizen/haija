import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/models/review.dart';
import 'package:final_project_haija/services/review_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingReviewScreen extends StatefulWidget {
  final Books book;
  RatingReviewScreen({required this.book, super.key});

  @override
  State<RatingReviewScreen> createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends State<RatingReviewScreen> {
  late User _user;
  double _rating = 0;
  String _reviewText = '';
  bool _hasReviewed = false;
  Review? _existingReview;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!; // Dapatkan pengguna saat ini
    _checkIfUserHasReviewed();
  }

  void _checkIfUserHasReviewed() async {
    Review? existingReview = await ReviewService.getUserReviewForBook(widget.book.idBook!, _user.uid);
    if (existingReview != null) {
      setState(() {
        _hasReviewed = true;
        _existingReview = existingReview;
        _rating = existingReview.rating;
        _reviewText = existingReview.comment ?? '';
      });
    }
  }

  void _submitReview() async {
    Review review = Review(
      idUser: _user.uid,
      rating: _rating,
      comment: _reviewText,
      reviewDate: DateTime.now(),
    );

    if (_hasReviewed) {
      // Edit existing review
      await ReviewService.editReviewForBook(widget.book.idBook!, review);
    } else {
      // Add new review
      await ReviewService.addNewReviewToBook(widget.book.idBook!, review);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.book.title,
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Image.network(
                widget.book.imageAsset,
                height: 200,
              ),
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Text(
                'Give Your Rating:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30.0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Comment',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your review here...',
              ),
              controller: TextEditingController(text: _reviewText),
              onChanged: (text) {
                setState(() {
                  _reviewText = text;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitReview,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
