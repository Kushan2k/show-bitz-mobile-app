import 'package:flutter/material.dart';

import 'package:show_bitz/services/movie_service.dart';
import 'package:show_bitz/utils/movie.dart';
import 'package:show_bitz/utils/styles.dart';
import 'package:show_bitz/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Now Playing",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: MovieService.loadMovies(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.data == null) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 250,
                                child: Center(
                                  child: Text(
                                    "Opps! loading failed\nPlease make sure your connection is up",
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                ),
                              )
                            ],
                          );
                        }

                        return SizedBox(
                          height: 330,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Movie m = Movie.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                video: m,
                                index: index,
                                now: true,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      case ConnectionState.waiting:
                        return showProgressIndicator();

                      default:
                        return showProgressIndicator();
                    }
                  },
                ),
                Text(
                  "Upcoming",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: MovieService.loadUpCommingMovie(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.data == null) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 250,
                                child: Center(
                                  child: Text(
                                    "Opps! loading failed",
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return SizedBox(
                          height: 330,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Movie m = Movie.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                video: m,
                                index: index,
                                now: false,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      case ConnectionState.waiting:
                        return showProgressIndicator();

                      default:
                        return showProgressIndicator();
                    }
                  },
                ),
                Text(
                  "Popular",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: MovieService.loadPopularMovies(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.data == null) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 250,
                                child: Center(
                                  child: Text(
                                    "Opps! loading failed",
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return SizedBox(
                          height: 330,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Movie m = Movie.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                video: m,
                                index: index,
                                now: false,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      case ConnectionState.waiting:
                        return showProgressIndicator();

                      default:
                        return showProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}

Widget showProgressIndicator() {
  return const SizedBox(
    height: 300,
    child: Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: 40,
        ),
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      ),
    ),
  );
}
