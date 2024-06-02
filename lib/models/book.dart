class Book {
  final String title;
  final String author;
  final DateTime publishedDate;
  final double? rating;
  final String description;
  final List<String> genre;
  final String imageAsset;
  bool isFavorite;

  Book(
      {required this.title,
      required this.author,
      required this.publishedDate,
      required this.rating,
      required this.description,
      required this.genre,
      required this.imageAsset,
      required this.isFavorite});
}
