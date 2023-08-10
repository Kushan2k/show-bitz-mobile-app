import 'package:show_bitz/utils/movie.dart';

class Actor {
  final String name;
  final int id;
  final String type;
  final String? img;
  // final List<Map<String, dynamic>> knownFor;

  const Actor(this.name, this.id, this.type, this.img);

  factory Actor.fromMap(Map<String, dynamic> map) {
    String url = "https://image.tmdb.org/t/p/original${map['profile_path']}";

    return Actor(
      map['original_name'],
      map['id'],
      map['known_for_department'],
      url,
    );
  }
}
