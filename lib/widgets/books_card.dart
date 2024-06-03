import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/services/author_service.dart';
import 'package:flutter/material.dart';
import 'package:final_project_haija/screens/detail_screen.dart';

class BooksCard extends StatefulWidget {
  final Books book;
  const BooksCard({super.key, required this.book});

  @override
  State<BooksCard> createState() => _BooksCardState();
}

class _BooksCardState extends State<BooksCard> {
  List<String> authorList = [];

  Future<void> _getAuthorName() async {
    for (var authorId in widget.book.author) {
      var name = await AuthorService.getAuthorName(authorId);
      authorList.add(name);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAuthorName();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.all(4),
          color: Colors.grey,
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: widget.book.imageAsset,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.book.imageAsset,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        widget.book.genre[0],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 3, right: 16),
                      child: Text(
                        widget.book.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 8),
                      child: Text(
                        authorList.join(', '),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(book: widget.book)),
                );
              },
            ),
          )),
        )
      ],
    );
  }
}
