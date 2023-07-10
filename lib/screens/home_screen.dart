import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:show_bitz/utils/constants.dart';
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
  Future<List> loadMovies() async {
    const url =
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";

    var response = await http.get(Uri.parse(url), headers: <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: authToken,
    });

    List<dynamic> resp = jsonDecode(response.body)['results'];

    return resp;
  }

  Future<List> loadPopularMovies() async {
    const url =
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1";

    var response = await http.get(Uri.parse(url), headers: <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: authToken,
    });

    List<dynamic> resp = jsonDecode(response.body)['results'];

    return resp;
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
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              String imgPath =
                                  snapshot.data?[index]['poster_path'];
                              String url =
                                  'https://image.tmdb.org/t/p/original$imgPath';
                              String title = snapshot.data?[index]['title'];

                              return MovieCard(
                                title: title,
                                img: url,
                                index: index,
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
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              String imgPath =
                                  snapshot.data?[index]['poster_path'];
                              String url =
                                  'https://image.tmdb.org/t/p/original$imgPath';
                              String title = snapshot.data?[index]['title'];

                              return MovieCard(
                                title: title,
                                img: url,
                                index: index,
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

// ListView.builder(
//                           itemBuilder: (context, index) {
//                             // print(snapshot.data);

//                             // print(title);
//                             // print(item[index]);
//                             // print('----------------------------------');
//                             // return MovieCard(
//                             //   title: title,
//                             // );
//                             return const Padding(
//                               padding: EdgeInsets.all(15),
//                               child: Text(
//                                 "hello",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             );
//                           },
//                           // itemCount: snapshot.data?['results'].length,
//                           itemCount: snapshot.data?.length,
//                           scrollDirection: Axis.horizontal,
//                         ),
