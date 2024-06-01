import 'package:final_project_haija/models/book.dart';
import 'package:final_project_haija/screens/detail_screen.dart';
import 'package:final_project_haija/screens/userlainprofile_screen.dart';
import 'package:flutter/material.dart';

class IndentedListView extends StatelessWidget {
  final List<Book> itemList;
  final double indent;

  const IndentedListView({
    required this.itemList,
    required this.indent
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (BuildContext context, int index) {
            Book book = itemList[index];
            return Stack(
              children: [ Card(
                color: Colors.grey,
                margin: book == itemList[0] ? EdgeInsets.only(left: indent, right: 5) : EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Image.network(
                        book.imageAsset,
                        height: 180),
                    Container(
                      width: 200,
                      height: 110,
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              book.genre[0],
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10
                              )
                          ),
                          Text(
                            book.title,
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
                              'book.author',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                margin: book == itemList[0] ? EdgeInsets.only(left: indent, right: 5) : EdgeInsets.symmetric(horizontal: 5),
                height: 300,
                width: 200,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    // onTap: () => Navigator.push(
                    //   // context,
                    //   // MaterialPageRoute(builder: (context) => DetailScreen(book: itemList[index])),
                    // ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              )
              ],
            );
          }),
    );
  }
}
