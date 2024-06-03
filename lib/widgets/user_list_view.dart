import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/app_user.dart';
import 'package:final_project_haija/screens/userlainprofile_screen.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserListView extends StatelessWidget {
  final Stream<List<AppUser>> function;
  final String currentUserId;
  
  const UserListView({
    required this.function, 
    required this.currentUserId, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
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
            return SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: snapshot.data!.map((document) {
                  if (document.userId! != currentUserId) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: 
                                document.profilePicture != null
                                ? CachedNetworkImage(
                                  imageUrl: document.profilePicture!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                                : Container(
                                  height: 100,
                                  width: 100,
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
                                    height: 100,
                                    width: 100,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserLainProfileScreen(user: document)));
                                  },
                                ),
                              )
                            ],
                          ),
                          RichText(
                          text: TextSpan(
                            text: document.username,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserLainProfileScreen(user: document)));
                            }
                          ),
                        ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                              child: 
                              document.profilePicture != null
                              ? CachedNetworkImage(
                                imageUrl: document.profilePicture!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                              : Container(
                                height: 100,
                                width: 100,
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
                                  height: 100,
                                  width: 100,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                                },
                              ),
                            )
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'You',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                            }
                          ),
                        ),
                      ],
                    );
                  }
                }).toList(),
              ),
            );
        }
      },
    );
  }
}