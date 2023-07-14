import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_bitz/services/movie_service.dart';
import 'package:show_bitz/utils/colors.dart';
import 'package:show_bitz/utils/video.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Video movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: FutureBuilder(
          future: MovieService.loadMovieDetails(movie: movie),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                var item = snapshot.data;
                if (item == null) {
                  return const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text("Opps!"),
                      ],
                    ),
                  );
                }

                double rate = item['vote_average'];
                String imgUrl =
                    "https://image.tmdb.org/t/p/original${item['poster_path']}";
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Stack(children: [
                          CachedNetworkImage(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: imgUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
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
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 40,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.green,
                                      size: 27,
                                    ),
                                  )),
                            ),
                          ),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.star_rate,
                                color: Colors.yellow,
                                size: 25,
                              ),
                            ),
                            Text(
                              double.parse(rate.toString()).toStringAsFixed(1),
                              style: const TextStyle(color: Colors.white54),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white30),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    item['original_language'],
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(item['release_date'],
                                style: const TextStyle(
                                  color: Colors.white60,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            item['overview'],
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case ConnectionState.waiting:
                return showProgress();
              default:
                return showProgress();
            }
          },
        ));
  }
}

showProgress() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.green,
    ),
  );
}
