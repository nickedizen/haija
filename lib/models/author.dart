import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String authorName;
  String? authorDescription;
  String? authorProfileUrl;
  List<String>? idBooks;

  Author({
    required this.authorName,
    this.authorDescription,
    this.authorProfileUrl,
    this.idBooks
  });

  factory Author.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Author(
      authorName: data['authorName'],
      authorDescription: data['authorDescription'],
      authorProfileUrl: data['authorProfileUrl'],
      idBooks: data['idBooks']
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'authorName': authorName,
      'authorDescription': authorDescription,
      'authorProfileUrl': authorProfileUrl,
      'idBooks': idBooks
    };
  }
}