import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/services/author_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AuthorEditScreen extends StatefulWidget {
  final Author? author;

  const AuthorEditScreen({super.key, this.author});

  @override
  State<AuthorEditScreen> createState() => _AuthorEditScreenState();
}

class _AuthorEditScreenState extends State<AuthorEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final picker = ImagePicker();
  XFile? _imageFile;

  void saveChanges() async {
    String? imageUrl;
    if (widget.author == null) {
      if (_imageFile != null) {
        imageUrl = await AuthorService.uploadImage(_imageFile!);
      }
      Author author = Author(
        authorName: _nameController.text,
        authorDescription: _descriptionController.text,
        authorProfileUrl: imageUrl
      );
     AuthorService.addNewAuthor(author);
    } else {
      if (_imageFile != null) {
        imageUrl = await AuthorService.uploadImage(_imageFile!);
      } else {
        imageUrl = widget.author!.authorProfileUrl;
      }
      widget.author!.authorName = _nameController.text;
      widget.author!.authorDescription = _descriptionController.text;
      widget.author!.authorProfileUrl = imageUrl;      
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

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

  @override
  void initState() {
    // TODO: implement initState
    if (widget.author != null) {
      _nameController.text = widget.author!.authorName;
      _descriptionController.text = widget.author!.authorDescription!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.author == null ? 'Add Author' : 'Update Author'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
              else (widget.author?.authorProfileUrl != null && Uri.parse(widget.author!.authorProfileUrl!).isAbsolute
                ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.author!.authorProfileUrl!,
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
                )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Name: ',
                textAlign: TextAlign.start,
              ),
              TextField(
                controller: _nameController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Description: ',
                ),
              ),
              TextField(
                controller: _descriptionController,
              ),
              const SizedBox(
                height: 32,
              ),

              ElevatedButton(
                onPressed: () {
                  saveChanges();
                  Navigator.of(context).pop();
                },
                child: Text(widget.author == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
