import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/app_user.dart';
import 'package:final_project_haija/screens/userprofile_screen.dart';
import 'package:final_project_haija/services/appuser_service.dart';
import 'package:final_project_haija/services/location_service.dart';
import 'package:final_project_haija/widgets/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final AppUser user;

  const EditProfileScreen({required this.user, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  XFile? _imageFile;
  final picker = ImagePicker();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool _meetUp = false;
  double? _latitude;
  double? _longitude;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
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
              const ListTile(
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

  Future<void> _pickLocation() async {
    final currentPosition = await LocationService.getCurrentPosition();
    setState(() {
      _latitude = currentPosition?.latitude;
      _longitude = currentPosition?.longitude;
    });
  }

  void _saveChanges() async {
    widget.user.username = usernameController.text;
    widget.user.profileBio = bioController.text;
    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await AppUserService.uploadImage(_imageFile!);
    } else {
      imageUrl = widget.user.profilePicture;
    }
    widget.user.profilePicture = imageUrl;
    if (_meetUp) {
      await _pickLocation();
      widget.user.latitude = _latitude;
      widget.user.longitude = _longitude;
    } else {
      widget.user.latitude = null;
      widget.user.longitude = null;
    }
    AppUserService.updateAppUser(widget.user);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const UserProfileScreen()),
        ModalRoute.withName('/'));
  }

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.user.username;
    bioController.text = widget.user.profileBio ?? '';
    _latitude = widget.user.latitude;
    _longitude = widget.user.longitude;
    _meetUp = widget.user.latitude != null && widget.user.longitude!= null ? true : false;
  }

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
                const Padding(
                    padding: EdgeInsets.only(top: 60, left: 15),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 25),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 60, left: 7, right: 15),
                    child: TextButton(
                        onPressed: () {
                          _saveChanges();
                        },
                        child: const Text('Save'))),
              ]),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                if (_imageFile != null)
                                  ClipOval(
                                    child: Image.file(
                                      File(_imageFile!.path),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                else (widget.user.profilePicture != null && Uri.parse(widget.user.profilePicture!).isAbsolute
                                  ? ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.user.profilePicture!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover
                                    ),
                                  )
                                  : ClipOval(
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
                                  )),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: TextField(
                            controller: usernameController,
                            decoration:
                                const InputDecoration(hintText: 'Input nama'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('Bio',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: TextField(
                            controller: bioController,
                            decoration:
                                const InputDecoration(hintText: 'Input Bio'),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SwitchListTile(
                          title: const Text(
                            'Izinkan Meetup',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          value: _meetUp,
                          onChanged: (value) {
                            setState(() {
                              _meetUp = value;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(selectedIndex: 3));
  }
}
