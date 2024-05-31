import 'package:final_project_haijo/data/book_data.dart';
import 'package:final_project_haijo/screens/chat_screen.dart';
import 'package:final_project_haijo/screens/ratingreview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_project_haijo/models/book.dart';

class DetailScreen extends StatefulWidget {
  final Book book;
  const DetailScreen({super.key, required this.book});

  @override
  State<DetailScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //memeriksa status sign in saat layar dimuat
    _loadFavoriteStatus(); //memeruksa status favorite saat layar dimuat
  }

  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool favorite = prefs.getBool('favorite_${widget.book.title}') ?? false;
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favoriteBooks = prefs.getStringList('favorite_books') ?? [];
    bool favoriteStatus = !isFavorite;

    if (favoriteStatus) {
      // Tambahkan buku ke daftar favorit
      if (!favoriteBooks.contains(widget.book.title)) {
        favoriteBooks.add(widget.book.title);
      }
    } else {
      // Hapus buku dari daftar favorit
      favoriteBooks.remove(widget.book.title);
    }

    // Simpan daftar favorit ke Shared Preferences
    prefs.setStringList('favorite_books', favoriteBooks);

    prefs.setBool('favorite_${widget.book.title}', favoriteStatus);
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 13, right: 15),
                  child: TextField(
                    style: TextStyle(height: 0.1),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(width: 0.8),
                        ),
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30.0,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {},
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 13, right: 15),
              child: IconButton(
                icon: Icon(Icons.chat_bubble),
                onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ChatScreen())));
            });
                  
                },
              ),
            ),
          ]),
          // Wrap(
          //   children: [
          //     Padding(
          //         padding: EdgeInsets.only(top: 27, left: 27, right: 27),
          //         child: Text(
          //           widget.book.title,
          //           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //           textAlign: TextAlign.center,
          //         )),
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.book.imageAsset,
                        height: 210,
                        width: 130,
                      ),
                    )),

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Row(
                //         children: [
                //           Padding(
                //               padding: EdgeInsets.only(left: 27),
                //               child: Icon(
                //                 Icons.person,
                //                 color: Colors.black,
                //                 size: 30,
                //               )
                //           ),
                //           Padding(
                //               padding: EdgeInsets.only(left: 10),
                //               child: Text(
                //                 'Author',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //                 textAlign: TextAlign.left,
                //               )
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children : [
                //           Padding(
                //               padding: EdgeInsets.only(top: 10, left: 27),
                //               child: Text(
                //                 widget.book.author,
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //                 textAlign: TextAlign.left,
                //               )
                //           ),

                //         ]
                //       ),

                //       const Row(
                //         children: [
                //           Padding(
                //               padding: EdgeInsets.only(top: 30, left: 27),
                //               child: Icon(
                //                 Icons.star,
                //                 color: Colors.yellow,
                //                 size: 30,
                //               )
                //           ),
                //           Padding(
                //               padding: EdgeInsets.only(top: 33, left: 10),
                //               child: Text(
                //                 'Rating',
                //                 style: TextStyle(
                //                     fontSize: 18, fontWeight: FontWeight.bold),
                //                 textAlign: TextAlign.left,
                //               )
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Padding(
                //             padding: EdgeInsets.only(top: 8, left: 27),
                //             child: Text(
                //               '${widget.book.rating}',
                //               style: TextStyle(
                //                 fontSize: 18, fontWeight: FontWeight.bold),
                //               textAlign: TextAlign.left,
                //             )
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(top: 8, left: 10),
                //             child: Text(
                //               '/ 5',
                //               style: TextStyle(
                //                 fontSize: 18, fontWeight: FontWeight.bold),
                //               textAlign: TextAlign.left,
                //             )
                //           ),
                //         ]
                //       ),
                //     ],
                // ),
              ],
            ),
          ),
          Container(
              color: Colors.grey,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 7, right: 20),
                    child: FavoriteButton(
                      isFavorite: !isFavorite,
                      onPress: () {
                        _toggleFavorite();
                      },
                    ),)
              ])),

          Wrap(
            children: [Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  widget.book.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    
                  ),
                  
                  textAlign: TextAlign.center,
                ),
              ),
            ]),]
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'by ' + widget.book.author,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.star_border)),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '${widget.book.rating} / 5' + ' | 120 ratings',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Loved by 405 Users',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Description',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Divider(
            height: 20,
            thickness: 4,
            color: Colors.grey,
            indent: 70,
            endIndent: 70,
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              widget.book.description,
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.justify,
                            )),
                      ],
                    ),
                  ])),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RatingReviewScreen()),
                );
                },
                child: Text(
                  'Write a Review',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Rating & Reviews',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Divider(
            height: 20,
            thickness: 4,
            color: Colors.grey,
            indent: 70,
            endIndent: 70,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2, left: 20),
                    child: Column(children: [
                      ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 25),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('User 1 rated it '),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('May 22, 2024 10:09')],
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        'HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaa'),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2, left: 20),
                    child: Column(children: [
                      ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 25),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('User 1 rated it '),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('May 22, 2024 10:09')],
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        'HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaa'),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          Text('Loved By',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Divider(
            height: 20,
            thickness: 4,
            color: Colors.grey,
            indent: 70,
            endIndent: 70,
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Column(children: [
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 30),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text('User 1')
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Column(children: [
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 30),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text('User 1')
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Column(children: [
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 30),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text('User 1')
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Column(children: [
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 30),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text('User 1')
              ]),
            ),
          ]),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final Function() onPress;

  const FavoriteButton({required this.isFavorite, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: onPress,
    );
  }
}
