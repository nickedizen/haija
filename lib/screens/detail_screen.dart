import 'package:final_project_haijo/data/book_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
              padding: const EdgeInsets.only(top: 40, left: 13),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 45, right: 25),
              child: FavoriteButton(
                isFavorite: isFavorite,
                onPress: () {
                  _toggleFavorite();
                },
              ),
            ),
          ]),
          Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 27, left: 27, right: 27),
                  child: Text(
                    widget.book.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 25, left: 27),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.book.imageAsset,
                          height: 210,
                          width: 130,
                        ),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 27),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 30,
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Author',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                        ),
                      ],
                    ),
                    Row(
                      children : [
                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 27),
                            child: Text(
                              widget.book.author,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                        ),
                        
                      ]
                    ),

                    const Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 30, left: 27),
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 30,
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 33, left: 10),
                            child: Text(
                              'Rating',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 27),
                          child: Text(
                            '${widget.book.rating}',
                            style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 10),
                          child: Text(
                            '/ 5',
                            style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )
                        ),
                      ]
                    ),    
                  ],
              ),
            ],
          ),
          
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18, left: 27),
                child: Text(
                  'Genres:',
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold,),
                  textAlign: TextAlign.left,
                ),
              ),
            ]
          ),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18, left: 27),
                child: Text(
                  widget.book.genre.join(', '),
                  style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ]
          ),
          const Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 34, left: 27),
                  child: Text(
                    'Sinopsis:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.book.description,
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.justify,
                            )),
                      ],
                    ),
                  ]))
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
