import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/screens/userlainprofile_screen.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/review.dart';
import 'package:final_project_haija/models/app_user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewListView extends StatelessWidget {
  final Stream<List<Review>> function;

  const ReviewListView({
    required this.function,
    super.key,
  });

  Future<AppUser> _getUser(String userId) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('app-users').doc(userId).get();
    return AppUser.fromDocument(userSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<List<Review>>(
      stream: function,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No reviews available');
            }
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data!.map((review) {
                return FutureBuilder<AppUser>(
                  future: _getUser(review.idUser),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (userSnapshot.hasError || !userSnapshot.hasData) {
                      return const Text('Failed to load user data');
                    }
                    AppUser user = userSnapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  // color: Colors.red[50],
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Stack(
                                      children: [
                                        ClipOval(
                                          child: user.profilePicture != null
                                              ? CachedNetworkImage(
                                                  imageUrl: user.profilePicture!,
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: const CircleAvatar(
                                                    backgroundImage: AssetImage("images/placeholder_image.png"),
                                                  ),
                                                ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            customBorder: const CircleBorder(),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                            ),
                                            onTap: () {
                                              if (user.userId == currentUserId) {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => const UserProfileScreen()
                                                ));
                                              } else {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => UserLainProfileScreen(user: user)
                                                ));
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    // color: Colors.pink[50],
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: user.username,
                                                style: const TextStyle(color: Colors.lightBlue),
                                                recognizer: TapGestureRecognizer()..onTap = () {
                                                  if (user.userId == currentUserId) {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => const UserProfileScreen()
                                                    ));
                                                  } else {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => UserLainProfileScreen(user: user)
                                                    ));
                                                  }
                                                }
                                              ),
                                            ),
                                            const Text(' rated it '),
                                            RatingBarIndicator(
                                              rating: review.rating,
                                              itemBuilder: (context, index) => const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 20.0, // Adjust the size of the stars
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                        Text(review.reviewDate.toString())
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Expanded(
                              child: Text(
                                review.comment ?? '',
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            );
        }
      },
    );
  }
}
