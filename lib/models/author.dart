import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String? authorId;
  String authorName;
  String? authorDescription;
  String? authorProfileUrl;
  DateTime? authorDataCreated;
  List<String>? idBooks;

  Author(
      {this.authorId,
      required this.authorName,
      this.authorDescription,
      this.authorProfileUrl,
      this.authorDataCreated,
      this.idBooks});

  factory Author.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Author(
        authorName: data['authorName'],
        authorDescription: data['authorDescription'],
        authorProfileUrl: data['authorProfileUrl'],
        authorDataCreated: data['authorDataCreated'],
        idBooks: data['idBooks']);
  }

  Map<String, dynamic> toDocument() {
    return {
      'authorName': authorName,
      'authorDescription': authorDescription,
      'authorProfileUrl': authorProfileUrl,
      'authorDataCreated': authorDataCreated,
      'idBooks': idBooks
    };
  }
}
