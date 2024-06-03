import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_haija/models/author.dart';
import 'package:final_project_haija/models/books.dart';
import 'package:final_project_haija/screens/book_edit_screen.dart';
import 'package:final_project_haija/screens/main_screen.dart';
import 'package:final_project_haija/screens/ratingreview_screen.dart';
import 'package:final_project_haija/services/appuser_service.dart';
import 'package:final_project_haija/services/author_service.dart';
import 'package:final_project_haija/widgets/user_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final Books book;
  const DetailScreen({super.key, required this.book});

  @override
  State<DetailScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<DetailScreen> {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _authorCollection =
      _database.collection('authors');
  static final CollectionReference _userCollection = _database.collection('app-users');
  static final CollectionReference _bookCollection =
      _database.collection('books');
  late String currentUserId;
  List<Author> listAuthor = [];
  bool isFavorite = false;
  late int lovedBy;
  String? currentUserStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserStatus();
    _getListAuthor();
    isFavorite = checkIfLiked();
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    lovedBy = widget.book.idOfUsersLikeThisBook != null ? widget.book.idOfUsersLikeThisBook!.length : 0;
  }
  void _getUserStatus() async {
    final userStatus = await AppUserService.getUserStatus();
    setState(() {
      currentUserStatus = userStatus;
    });
  }
  Future<void> _getListAuthor() async {
    for (var authorId in widget.book.author) {
      var author = await AuthorService.getSpecificAuthorData(authorId);
      listAuthor.add(author);
    }
  }

  bool checkIfLiked() {
    var idUser = FirebaseAuth.instance.currentUser!.uid;
    if (widget.book.idOfUsersLikeThisBook == null || widget.book.idOfUsersLikeThisBook == 0) {
      return false;
    } else {
      if (widget.book.idOfUsersLikeThisBook!.contains(idUser)) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getListAuthor(),
      builder: (context, snapshot) {
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
                    onPressed: () {},
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
                  ],
                ),
              ),
              Container(
                  color: Colors.grey,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 7, right: 20),
                        child: isFavorite
                        ? IconButton(
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                          onPressed: () async {
                            setState(() {
                              isFavorite = false;
                              lovedBy--;
                            });
                            await _bookCollection.doc(widget.book.idBook).update({
                              'idOfUsersLikeThisBook': FieldValue.arrayRemove([currentUserId])
                            });
                            await _userCollection.doc(currentUserId).update({
                              'favoriteBooks': FieldValue.arrayRemove([widget.book.idBook])
                            });
                          },
                        )
                        : IconButton(
                          icon: const Icon(Icons.favorite_border_outlined),
                          color: Colors.white,
                          onPressed: () async {
                            setState(() {
                              isFavorite = true;
                              lovedBy++;
                            });
                            await _bookCollection.doc(widget.book.idBook).update({
                              'idOfUsersLikeThisBook': FieldValue.arrayUnion([currentUserId])
                            });
                            await _userCollection.doc(currentUserId).update({
                              'favoriteBooks': FieldValue.arrayUnion([widget.book.idBook])
                            });
                          },
                        )
                        ),
                  ])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  widget.book.title,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (currentUserStatus == 'admin')
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BookEditScreen(book: widget.book))
                  );
                }, 
                child: const Text('Edit Book')
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                    text: 'by ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: listAuthor[0].authorName,
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
                      }
                    ),
                  ],
                )
              ),
              
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
                    '${widget.book.rating ?? 0} / 5 | ${widget.book.reviews != [] ? widget.book.reviews!.length : 0} reviews',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    ' Loved by $lovedBy Users',
                    style: const TextStyle(
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
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RatingReviewScreen(book: widget.book)),
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
              UserListView(function: AppUserService.getUserLikeThisBookStream(widget.book.idBook!), currentUserId: currentUserId),
              const SizedBox(
                height: 20,
              )
            ]),
          ),
        );
      }
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
