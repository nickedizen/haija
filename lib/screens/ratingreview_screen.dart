import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/models/review.dart';
import 'package:final_project_haija/services/review_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';



class RatingReviewScreen extends StatefulWidget {
  Books book;
  RatingReviewScreen({required this.book, super.key});

  @override
  State<RatingReviewScreen> createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends State<RatingReviewScreen> {
  late User _user;
  double _rating = 0;
  String _reviewText = '';


  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!; // Dapatkan pengguna saat ini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.book.title,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Image.asset(
                'assets/dorian_gray.png',
              ),
            ),
            const SizedBox(height: 10.0),
            const Center(
              child: Row(
                children: <Widget>[
                  Text(
                  'Author : ',
                  style: TextStyle(
                  fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
                
            const SizedBox(height: 10.0),
            const Center(
              child: Row(
                children: <Widget>[
                  Text(
                  'Category : ',
                  style: TextStyle(
                  fontSize: 18.0,
                    ),
                  ),
                ],
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
              onChanged: (text) {
                setState(() {
                  _reviewText = text;
                });
              },
            ),
            const SizedBox(height: 20.0),
           ElevatedButton(
  onPressed: () async {
    Review review = Review(
      idUser: _user.uid, // Ganti dengan user ID yang sesuai
      rating: _rating,
      comment: _reviewText,
      reviewDate: DateTime.now(),
    );
    await ReviewService.addNewReviewToBook(widget.book.id, review);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Review has been added.'),
      ),
    );
  },
  child: const Text('Submit'),
),

          ],
        ),
      ),
    );
  }
}
