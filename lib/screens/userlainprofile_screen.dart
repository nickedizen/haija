import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/app_user.dart';
import 'package:final_project_haija/services/books_service.dart';
import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:final_project_haija/widgets/new_indented_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../data/book_data.dart';
import '../widgets/indented_list_view.dart';

class UserLainProfileScreen extends StatefulWidget {
  final AppUser user;
  const UserLainProfileScreen({required this.user, super.key});

  @override
  State<UserLainProfileScreen> createState() => _UserLainProfileScreenState();
}

class _UserLainProfileScreenState extends State<UserLainProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 15),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 13, right: 15),
                      child: TextField(
                        style: TextStyle(height: 0.1),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            hintText: 'Search',
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 30.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {},
                            )),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 13, right: 15),
                  child: IconButton(
                    icon: Icon(Icons.chat_bubble),
                    onPressed: () {},
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    //TODO: 2. Buat bagian ProfileHeader yang berisi gambar profil
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            if (widget.user.profilePicture != null && Uri.parse(widget.user.profilePicture!).isAbsolute)
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: widget.user.profilePicture!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover
                                ),
                              )
                            else
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const CircleAvatar(
                                    radius: 60,
                                    backgroundImage: AssetImage(
                                        "images/placeholder_image.png"),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.user.username,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Divider(
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              'ADD FRIEND',
                              style: TextStyle(fontSize: 20),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              'MEETUP',
                              style: TextStyle(fontSize: 20),
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.user.profileBio != null
                      ? widget.user.profileBio!
                      : ''
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 20,
                      thickness: 3,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Favorite Books',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Divider(
                      height: 20,
                      thickness: 4,
                      color: Colors.grey,
                      indent: 70,
                      endIndent: 70,
                    ),
                    SizedBox(height: 30),
                    NewIndentedListView(function: BooksService.getUserFavoriteBooksStream(widget.user.userId!)),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 20,
                      thickness: 3,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Friends',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Divider(
                      height: 20,
                      thickness: 4,
                      color: Colors.grey,
                      indent: 70,
                      endIndent: 70,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Column(children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 30),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Text('User 1')
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Column(children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 30),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Text('User 1')
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Column(children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 30),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Text('User 1')
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Column(children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 30),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Text('User 1')
                            ]),
                          ),
                        ]),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(selectedIndex: 3));
  }
}
