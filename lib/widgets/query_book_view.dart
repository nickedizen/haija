import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/screens/detail_screen.dart';
import 'package:final_project_haija/screens/userlainprofile_screen.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class QueryBookView extends StatelessWidget {
  final Stream<List<Books>> function;
  const QueryBookView({required this.function, super.key});

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
                          CachedNetworkImage(
                            imageUrl: document.imageAsset!,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Container(
                                height: 125,
                                width: 75,
                              ),
                              onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(book: document)));
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: document.title,
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(book: document)));
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