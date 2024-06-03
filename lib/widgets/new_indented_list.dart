import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/screens/detail_screen.dart';
import 'package:final_project_haija/services/books_service.dart';
import 'package:flutter/material.dart';

class NewIndentedListView extends StatelessWidget {
  final Stream<List<Books>> function;
  const NewIndentedListView({required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: function, 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default: 
            return SizedBox(
              height: 310,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: snapshot.data!.map((document) {
                  List<String> name = [];
                  if (document.author.isNotEmpty) {
                    name = document.author[0].split('-');
                  }
                  return Stack(
                    children: [
                      Card(
                        color: Colors.grey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CachedNetworkImage(
                              imageUrl: document.imageAsset,
                              height: 180,
                            ),
                            Container(
                              width: 200,
                              height: 110,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      document.genre.isNotEmpty
                                      ? document.genre[0]
                                      : '',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10
                                      )
                                  ),
                                  Text(
                                    document.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      name.isNotEmpty 
                                      ? name[0]
                                      : '',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11
                                      )
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ),
                       AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        height: 310,
                        width: 205,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => DetailScreen(book: document))
                              );
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            );
        }
      }
    );
  }
}