import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_bitz/screens/movie_detail_screen.dart';

import 'package:show_bitz/utils/video.dart';

class MovieCard extends StatelessWidget {
  // final String title;
  // final String img;
  final int index;
  final Video movie;
  final bool now;

  const MovieCard({
    super.key,
    required this.movie,
    required this.index,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MovieDetailsScreen(
            movie: movie,
          );
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
                imageUrl: movie.imgUrl,
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
                  movie.title,
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
