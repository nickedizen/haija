import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/app_user.dart';
import 'package:final_project_haija/screens/userlainprofile_screen.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class QueryUserView extends StatelessWidget {
  final Stream<List<AppUser>> function;
  const QueryUserView({required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: function, 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default: 
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data!.map((document) {
                return SizedBox(
                  height: 75,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          ClipOval(
                            child: 
                            document.profilePicture != null
                            ? CachedNetworkImage(
                              imageUrl: document.profilePicture!,
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            )
                            : Container(
                              height: 75,
                              width: 75,
                              child: const CircleAvatar(
                                backgroundImage: AssetImage(
                                    "images/placeholder_image.png"
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              child: Container(
                                height: 75,
                                width: 75,
                              ),
                              onTap: () {
                                if (document.userId != currentUserId) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserLainProfileScreen(user: document)));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                                }
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: document.username,
                          recognizer: TapGestureRecognizer()..onTap = () {
                            if (document.userId != currentUserId) {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserLainProfileScreen(user: document)));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                            }
                          }
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
        }
      }
    );
  }
}