import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_bitz/screens/movie_detail_screen.dart';
import 'package:show_bitz/utils/type.dart';

import 'package:show_bitz/utils/video.dart';

class MovieCard extends StatelessWidget {
  // final String title;
  // final String img;
  final int index;
  final Video video;
  final bool now;

  const MovieCard({
    super.key,
    required this.video,
    required this.index,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          switch (video.type) {
            case Types.movie:
              return MovieDetailsScreen(
                movie: video,
              );
            case Types.series:
              return showAlertDialog(context);
            default:
              return showAlertDialog(context);
          }
        }));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: index == 0
              ? const EdgeInsets.only(
                  left: 0,
                  top: 10,
                  bottom: 10,
                  right: 5,
                )
              : const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                width: 170,
                fit: BoxFit.fill,
                imageUrl: video.imgUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.greenAccent,
                            value: downloadProgress.progress),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Text(
                  video.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AlertDialog showAlertDialog(BuildContext context) {
  return (AlertDialog(
    alignment: Alignment.center,
    content: const Text(
        "we are currently in uder development proccess of this action please check for the updates regularly!"),
    iconColor: Colors.red,
    surfaceTintColor: Colors.grey[400],
    icon: const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Icon(
        Icons.info_sharp,
        size: 26,
      )
    ]),
    title: const Text(
      "Under Development",
      textAlign: TextAlign.start,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Ok"),
      ),
    ],
    actionsPadding: const EdgeInsets.all(10),
    elevation: 10,
  ));
}
