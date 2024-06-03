import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/services/author_service.dart';
import 'package:final_project_haija/services/books_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class BookEditScreen extends StatefulWidget {
  final Books? book;

  const BookEditScreen({super.key, this.book});

  @override
  State<BookEditScreen> createState() => _BookEditScreenState();
}

class _BookEditScreenState extends State<BookEditScreen> {
  final authorCollection = FirebaseFirestore.instance.collection('authors');
  final genreCollection = FirebaseFirestore.instance.collection('genres');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _imageFile;
  List<Map<String, String>>? _authorList;
  List<String> _selectedAuthorName = [];
  List<String> _selectedAuthorId = [];
  DateTime? _selectedDate;
  List<String>? _genreList;
  List<String> _selectedGenre = [];

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _descriptionController.text = widget.book!.description;
      _selectedDate = widget.book!.publishedDate;
      _selectedAuthorId = widget.book!.author;
      _selectedGenre = widget.book!.genre;
      _fillAuthorNameList();
    }
    _getAuthorList();
    _getGenres();
  }

  Future<void> _fillAuthorNameList() async {
    for (var authorId in _selectedAuthorId) {
      var authorName = await AuthorService.getAuthorName(authorId);
      _selectedAuthorName.add(authorName);
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

Future<void> _getAuthorList() async {
    // Get your data from Firestore
    final authorSnapshot = await authorCollection.get();
    
    List<Map<String, String>> items = [];
    for (var doc in authorSnapshot.docs) {
      String itemName = doc.get('authorName');
      String itemId = doc.id;

      items.add({
          'authorId': itemId,
          'authorName': itemName
        }
      );
    }
    setState(() {
      _authorList = items;
    });
  }

  Future<void> _getGenres() async {
    final genreSnapshot = await genreCollection.get();
    List<String> genres = [];

    for (var genre in genreSnapshot.docs) {
      genres.add(genre.id);
    }

    setState(() {
      _genreList = genres;
    });
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
    }
  }

  void _authorDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Choose Authors'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var author in _authorList!)
                      CheckboxListTile(
                        title: Text(author['authorName']!),
                        value: _selectedAuthorName.contains(author['authorName']!),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              if (value) {
                                _selectedAuthorName.add(author['authorName']!);
                                _selectedAuthorId.add(author['authorId']!);
                              } else {
                                _selectedAuthorName.remove(author['authorName']!);
                                _selectedAuthorId.remove(author['authorId']!);
                              }
                            }
                          });
                        },
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    // Use the selectedGenre list after the dialog is dismissed
  }


  void _genreDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Choose Genres'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var genre in _genreList!)
                      CheckboxListTile(
                        title: Text(genre),
                        value: _selectedGenre.contains(genre),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              if (value) {
                                _selectedGenre.add(genre);
                              } else {
                                _selectedGenre.remove(genre);
                              }
                            }
                          });
                        },
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    // Use the selectedGenre list after the dialog is dismissed
  }

  void _saveChanges() async {
    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await BooksService.uploadImage(_imageFile!);
    } else {
      imageUrl = widget.book!.imageAsset;
    }

    if (widget.book == null) {
      Books newBook = Books(
        title: _titleController.text,
        author: _selectedAuthorId,
        genre: _selectedGenre,
        publishedDate: _selectedDate!,
        description: _descriptionController.text,
        imageAsset: imageUrl!
      );

      BooksService.addNewBook(newBook, context);
    } else {
        widget.book!.title = _titleController.text;
        widget.book!.author = _selectedAuthorId;
        widget.book!.genre = _selectedGenre;
        widget.book!.description = _descriptionController.text;
        widget.book!.imageAsset = imageUrl!;

        BooksService.updateBook(widget.book!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Update Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title: ',
                textAlign: TextAlign.start,
              ),
              TextField(
                controller: _titleController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Author: ',
                ),
              ),
              ElevatedButton(
                onPressed: () => _authorDialog(), 
                child: const Text('Pick Authors')
              ),              
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Published Date: ',
                ),
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context), 
                child: const Text('Pick a Date')
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Genre: ',
                ),
              ),
              ElevatedButton(
                onPressed: () => _genreDialog(), 
                child: const Text('Select Genres')
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
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Image: '),
              ),
              _imageFile != null
                  ? AspectRatio(
                      aspectRatio: 1 / 1.5,
                      child: kIsWeb
                          ? CachedNetworkImage(
                              imageUrl: _imageFile!.path,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            )
                          : Image.file(
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                            ))
                  : (widget.book?.imageAsset != null &&
                          Uri.parse(widget.book!.imageAsset).isAbsolute
                      ? AspectRatio(
                          aspectRatio: 1 / 1.5,
                          child: CachedNetworkImage(
                            imageUrl: widget.book!.imageAsset!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        )
                      : Container()),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),

              const SizedBox(
                height: 32,
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _saveChanges(),
                      child: Text(widget.book == null ? 'Add' : 'Update'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
