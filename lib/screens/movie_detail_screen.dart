import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_bitz/services/movie_service.dart';
import 'package:show_bitz/utils/colors.dart';
import 'package:show_bitz/utils/type.dart';
import 'package:show_bitz/utils/video.dart';

import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Video movie;
  const MovieDetailsScreen({super.key, required this.movie});

  void lunchWeb(String u, BuildContext context) async {
    try {
      Uri url = Uri.parse(u);
      bool canlunch = await canLaunchUrl(url);

      if (canlunch) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        AlertDialog(
          title: const Text("Failed to open url"),
          icon: const Icon(
            Icons.error_outline,
            size: 27,
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"))
          ],
        );
      }
    } catch (er) {
      AlertDialog(
        title: const Text("Failed to open url"),
        content: Text(er.toString()),
        icon: const Icon(
          Icons.error_outline,
          size: 27,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"))
        ],
      );
    }
  }

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

                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Stack(children: [
                          CachedNetworkImage(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: movie.imgUrl,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () =>
                                      lunchWeb(item['homepage'], context),
                                  child: const Text(
                                    "Visit ",
                                    style: TextStyle(
                                      color: Colors.lightGreen,
                                    ),
                                  )),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                  movie.type == Types.movie
                                      ? item['release_date']
                                      : item['first_air_date'],
                                  style: const TextStyle(
                                    color: Colors.white60,
                                  )),
                            ],
                          ),
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
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: item['genres']!.map<Widget>((item) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 77, 77, 77),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      item['name'] as String,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        item['vurl'] != null
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: GestureDetector(
                                  onTap: () => lunchWeb(item['vurl'], context),
                                  child: Stack(children: [
                                    CachedNetworkImage(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      imageUrl: item['tumbnail'],
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors
                                                              .greenAccent,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                                const Text(
                                                  "Loading.",
                                                  style: TextStyle(
                                                      color: Colors.white60),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: SizedBox(
                                        width: 60,
                                        height: 50,
                                        child: Image.asset(
                                          'assets/ylogo.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              )
                            : const SizedBox(
                                height: 2,
                              ),
                        movie.type == Types.series
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Seasons ${List.of(item['seasons']).length}",
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(
                                height: 2,
                              ),
                        movie.type == Types.series
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 40),
                                child: SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: List.of(item['seasons']).length,
                                    itemBuilder: (context, index) {
                                      var season = item['seasons'][index];
                                      String url;

                                      if (season['poster_path'] != null) {
                                        url =
                                            "https://image.tmdb.org/t/p/original${season['poster_path']}";
                                      } else {
                                        url =
                                            'https://www.movienewz.com/img/films/poster-holder.jpg';
                                      }

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              width: 150,
                                              fit: BoxFit.fill,
                                              imageUrl: url,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                      downloadProgress) {
                                                return Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors
                                                              .greenAccent,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    season['name'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Icon(
                                                            Icons.star_rate,
                                                            color:
                                                                Colors.yellow,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Text(
                                                          double.parse(season[
                                                                      'vote_average']
                                                                  .toString())
                                                              .toStringAsFixed(
                                                                  1),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 2,
                              )
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
