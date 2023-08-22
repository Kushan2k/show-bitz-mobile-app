import 'package:show_bitz/utils/type.dart';
import 'package:show_bitz/utils/video.dart';

final class Movie extends Video {
  Movie(
      {required super.title,
      required super.imgUrl,
      required super.id,
      required super.type});

  factory Movie.fromMap(Map<String, dynamic> map) {
    String url = "https://image.tmdb.org/t/p/original${map['poster_path']}";

    return Movie(
        title: map['title'], imgUrl: url, id: map['id'], type: Types.movie);
  }
}
