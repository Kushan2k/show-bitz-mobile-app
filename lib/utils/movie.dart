final class Movie {
  final String title;
  final String imgUrl;
  final int id;

  const Movie({
    required this.title,
    required this.imgUrl,
    required this.id,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    String url = "https://image.tmdb.org/t/p/original${map['poster_path']}";

    return Movie(
      title: map['title'],
      imgUrl: url,
      id: map['id'],
    );
  }
}
