import 'package:final_project_haija/models/genre.dart';
import 'package:final_project_haija/services/genre_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenreCreateScreen extends StatefulWidget {
  const GenreCreateScreen({super.key});

  @override
  State<GenreCreateScreen> createState() => _GenreCreateScreenState();
}

class _GenreCreateScreenState extends State<GenreCreateScreen> {
  final TextEditingController _genreNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Genre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Genre Name: ',
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _genreNameController,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Genre genre = Genre(genreName: _genreNameController.text);
                GenreService.addNewGenre(genre, context);
              },
              child: const Text('Create'),
            ),
        ],
        ),
      ),
    );
  }
}