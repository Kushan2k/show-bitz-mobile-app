import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:show_bitz/utils/constants.dart';
import 'package:show_bitz/utils/movie.dart';
import 'package:show_bitz/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:show_bitz/widgets/movie_card.dart';
// import 'package:show_bitz/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List?> loadMovies() async {
    const url =
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      return resp;
    } catch (error) {
      return null;
    }
  }

  Future<List?> loadUpCommingMovie() async {
    const url =
        "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      return resp;
    } catch (error) {
      return null;
    }
  }

  Future<List?> loadPopularMovies() async {
    const url =
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      return resp;
    } catch (error) {
      return null;
    }
  }

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
                Text(
                  "Now Playing",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: loadMovies(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.data == null) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Opps! loading failed",
                                style: TextStyle(color: Colors.white60),
                              )
                            ],
                          );
                        }

                        return SizedBox(
                          height: 350,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Movie m = Movie.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                movie: m,
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
                  future: loadUpCommingMovie(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.data == null) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Opps! loading failed",
                                  style: TextStyle(color: Colors.white60))
                            ],
                          );
                        }
                        return SizedBox(
                          height: 340,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Movie m = Movie.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                movie: m,
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
                  future: loadPopularMovies(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.data == null) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Opps! loading failed",
                                  style: TextStyle(color: Colors.white60))
                            ],
                          );
                        }
                        return SizedBox(
                          height: 340,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Movie m = Movie.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                movie: m,
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
