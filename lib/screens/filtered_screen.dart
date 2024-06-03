// import 'package:final_project_haija/data/book_data.dart';
// import 'package:final_project_haija/models/book.dart';
// import 'package:final_project_haija/widgets/book_card.dart';
// import 'package:flutter/material.dart';

// class FilteredScreen extends StatefulWidget {
//   final String genre;
//   final List<Book>? list;

//   const FilteredScreen({super.key, required this.genre, this.list});

//   @override
//   State<FilteredScreen> createState() => _FilteredScreenState();
// }

// class _FilteredScreenState extends State<FilteredScreen> {
//   List<Book> _listOfBooks = [];

//   @override
//   void initState() {
//     _listOfBooks = widget.list ?? bookList.where((item) => item.genre.contains(widget.genre)).toList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.genre),
//         backgroundColor: Colors.black,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 padding: const EdgeInsets.all(8),
//                 itemCount: _listOfBooks.length,
//                 itemBuilder: (context, index) {
//                   Book book = _listOfBooks[index];
//                   return BookCard(book: book);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
