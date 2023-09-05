import 'package:show_bitz/utils/type.dart';

abstract class Video {
  final String title;
  final String imgUrl;
  final int id;
  final Types type;
  final List<dynamic>? genres;

  const Video({
    required this.title,
    required this.imgUrl,
    required this.id,
    required this.type,
    this.genres,
  });
}
