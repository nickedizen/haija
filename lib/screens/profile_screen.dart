import 'dart:io';

import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../data/book_data.dart';
import '../models/book.dart';
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
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        //TODO: 2. Buat bagian ProfileHeader yang berisi gambar profil
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 200 - 50),
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
                                        radius: 50,
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

                        //TODO: 3. Buat buat ProfileInfo yang berisi info profil
                        SizedBox(height: 20),
                        //Divider(color: Colors.deepPurple[100]),
                        SizedBox(height: 4),
                        
                        Container(
                          width: double.infinity,
                          height: 60,
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color(0xffD9D9D9)
                          ),
                          child : ProfileInfoItem(
                            icon: Icons.lock,
                            label: 'Name',
                            value: userName,
                            showEditIcon: isSignedIn,
                            onEditPressed: () {
                              editUserName();
                              debugPrint('Icon edit ditekan ...');
                            },
                            iconColor: Colors.amber),
                        ),
                        SizedBox(height: 4),
                        //Divider(color: Colors.deepPurple[100]),
                        SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          height: 60,
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color(0xffD9D9D9)
                          ),
                          child : ProfileInfoItem(
                            icon: Icons.person,
                            label: 'E-mail',
                            value: email,
                            iconColor: Colors.black),
                        ),

                        SizedBox(height: 4),
                        //Divider(color: Colors.deepPurple[100]),
                        SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          height: 60,
                          margin: EdgeInsets.only(top: 16, bottom: 16),
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color(0xffD9D9D9)
                          ),
                          child : ProfileInfoItem(
                            icon: Icons.favorite,
                            label: 'Favorit',
                            value: '${favoriteBooks.length}',
                            iconColor: favoriteBooks.length > 0 ? Colors.red : Colors.grey,),
                        ),
                        

                        //TODO: 4. Buat ProfileAction yang berisi TextButton sign in/out
                        SizedBox(height: 4),
                        //Divider(color: Colors.deepPurple[100]),
                        SizedBox(height: 20),
                        // isSignedIn
                        //     ? TextButton(onPressed: signOut, child: Text('Sign Out'))
                        //     : TextButton(onPressed: signIn, child: Text('Sign In')),
                        Container(
                          width: double.infinity,
                          height: 45,
                          margin: EdgeInsets.only(top: 16),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushNamedAndRemoveUntil(context, '/welcome', ModalRoute.withName('/welcome'));
                            },
                            child: const Text(
                              "Log Out",
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 18
                              ),
                            ),
                          ),
                        ),
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
