import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/app_user.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/screens/editProfile_screen.dart';
import 'package:final_project_haija/screens/sign_in_screen.dart';
import 'package:final_project_haija/services/appuser_service.dart';
import 'package:final_project_haija/services/books_service.dart';
import 'package:final_project_haija/widgets/custom_appbar.dart';
import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:final_project_haija/widgets/new_indented_list.dart';
import 'package:final_project_haija/widgets/user_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  AppUser? user;
  late String userId;
  Stream<Books>? favoriteBooksId;
  final TextEditingController _editedUserNameController =
      TextEditingController();

  String _imageFile = '';
  final picker = ImagePicker();


  void _getUser() async {
    final appUser = await AppUserService.getAppUserData();
    setState(() {
      user = appUser;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile.path;
      });
    }
  }

  void _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Image Source',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop(_getImage(ImageSource.gallery));
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop(_getImage(ImageSource.camera));
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              Stack(
                children: [
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
                                if (user?.profilePicture != null && Uri.parse(user!.profilePicture!).isAbsolute)
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: user!.profilePicture!,
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
                        SizedBox(
                          height: 20,
                        ),
                        if (user != null)
                          Text(user!.username,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (user != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(
                                            user: user!,
                                          )));
                                }
                              },
                              child: const Text(
                                'EDIT PROFILE',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/pengaturan');
                              }, 

                              icon: Icon(Icons.settings),
                              label: const Text(
                                'SETTINGS',
                                style: TextStyle(fontSize: 20),
                              ),
                              ),
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
                        if (user != null)
                          Text(user!.profileBio ?? ''),
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
                        NewIndentedListView(function: BooksService.getUserFavoriteBooksStream(userId)),
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
                        UserListView(function: AppUserService.getFriendsStream(userId), currentUserId: userId),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => SignInScreen())
                            );
                          }, 
                          child: Text('Log Out'))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(selectedIndex: 2));
  }
}
