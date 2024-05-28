import 'dart:io';

import 'package:final_project_haijo/widgets/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../data/book_data.dart';
import '../models/book.dart';
import '../widgets/indented_list_view.dart';
import '../widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //TODO: 1. Deklarasikan variabel yang dibutuhkan
  
  bool isSignedIn = false;
  String email = '';
  String userName = '';
  int favoriteBookCount = 0;
  final TextEditingController _editedUserNameController = TextEditingController();

  String _imageFile = '';
  final picker = ImagePicker();

  List<Book> favoriteBooks = [];

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile.path;
      });
    }
  }

  void _saveProfileImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('_imageFile', path);
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
    _loadUserData();
    _loadFavoriteBooks();
  }

  // Load user data from SharedPreferences
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('key')) {
      String encryptedEmail =
          prefs.containsKey('email') ? prefs.getString('email') ?? '' : '';
      String encryptedUserName = prefs.getString('username') ?? '';

      final encrypt.Key key =
          encrypt.Key.fromBase64(prefs.getString('key') ?? '');
      final iv = encrypt.IV.fromBase64(prefs.getString('iv') ?? '');

      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final decryptedUsername = encrypter.decrypt64(encryptedUserName, iv: iv);
      final decryptedEmail = encrypter.decrypt64(encryptedEmail, iv: iv);

      setState(() {
        isSignedIn = prefs.getBool('isSignedIn') ?? false;
        email = decryptedEmail;
        userName = decryptedUsername;
      });
    }
  }

  void signIn() {
    Navigator.pushNamed(context, '/signin');
  }

  // Update SharedPreferences when signing out
  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false);
    prefs.setString('email', '');
    prefs.setString('userName', '');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushReplacementNamed(context, '/');
    });

    _loadUserData();
  }

  void editUserName() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Nama'),
          content: TextField(
            controller: _editedUserNameController,
            decoration: InputDecoration(labelText: 'Input nama'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (_editedUserNameController.text.isNotEmpty &&
                    prefs.containsKey('key') &&
                    prefs.containsKey('iv')) {
                  final encrypt.Key key =
                      encrypt.Key.fromBase64(prefs.getString('key') ?? '');
                  final iv = encrypt.IV.fromBase64(prefs.getString('iv') ?? '');

                  final encrypter = encrypt.Encrypter(encrypt.AES(key));
                  final encryptedUsername = encrypter.encrypt(
                    _editedUserNameController.text,
                    iv: iv,
                  );

                  prefs.setString('username', encryptedUsername.base64);

                  // Reload user data to update the state
                  _loadUserData();

                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadFavoriteBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorite_books') ?? [];
    setState(() {
      // favoriteBooks = favorites;
      favoriteBooks = favorites.map((id) {
        // Assuming bookList is a list of all available books
        return bookList.firstWhere((book) => book.title == id);
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
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
                      padding: const EdgeInsets.only(top: 60, left: 13, right: 15),
                      child: TextField(
                        style: TextStyle(height: 0.1),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 0.8),
                          ),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search,
                          size: 30.0,),
                          suffixIcon: IconButton(icon: Icon(Icons.clear),
                          onPressed: () {},)),
                          
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 13, right: 15),
                    child: IconButton(
                      icon: Icon(Icons.chat_bubble),
                      onPressed: () {},),
                  ),
                ]
              ),
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
                                if (_imageFile.isNotEmpty)
                                  ClipOval(
                                    child: Image.file(
                                      File(_imageFile),
                                      height: 100,
                                      fit: BoxFit.cover,
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
                                        backgroundImage:
                                            AssetImage("images/placeholder_image.png"),
                                      ),
                                    ),
                                  ),
                                if (isSignedIn)
                                  IconButton(
                                    onPressed: _showPicker,
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.deepPurple[50],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'AAn Pyongyang',
                          style: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 20),
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
                              child: Text('ADD FRIEND',
                              style: TextStyle(fontSize: 20),)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text('CHATt',
                              style: TextStyle(fontSize: 20),)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text('MEETUP',
                              style: TextStyle(fontSize: 20),)
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
                        SizedBox(height: 20,),
                        Text('Saya adalah tangan kanan kim jong un'),
                        SizedBox(height: 20,),
                        Divider(
                          height: 20,
                          thickness: 3,
                          color: Colors.black,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '10 Favorite Books',
                          style: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.bold)
                        ),
                        Divider(
                          height: 20,
                          thickness: 4,
                          color: Colors.grey,
                          indent: 70,
                          endIndent: 70,
                        ),
                        SizedBox(height: 30),
                        IndentedListView(itemList: bookList, indent: 15),
                        SizedBox(height: 20,),
                        Divider(
                          height: 20,
                          thickness: 3,
                          color: Colors.black,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Friends',
                          style: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.bold)
                        ),
                        Divider(
                          height: 20,
                          thickness: 4,
                          color: Colors.grey,
                          indent: 70,
                          endIndent: 70,
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Column(
                                children: [ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey, width: 30),
                                        shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Text('User 1')
                                ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Column(
                                children: [ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey, width: 30),
                                        shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Text('User 1')
                                ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Column(
                                children: [ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey, width: 30),
                                        shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Text('User 1')
                                ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Column(
                                children: [ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey, width: 30),
                                        shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Text('User 1')
                                ]
                              ),
                            ),
                            
                          ]
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(selectedIndex: 3)
    );
  }
}
