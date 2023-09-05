import 'package:show_bitz/utils/type.dart';
import 'package:show_bitz/utils/video.dart';

class Series extends Video {
  const Series({
    required super.title,
    required super.imgUrl,
    required super.id,
    required super.type,
    super.genres,
  });

  factory Series.fromMap(Map<String, dynamic> map) {
    String url = "https://image.tmdb.org/t/p/original${map['poster_path']}";

    return Series(
      title: map['name'],
      imgUrl: url,
      id: map['id'],
      type: Types.series,
      genres: map['genre_ids'],
    );
  }
}
