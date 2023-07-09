import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:show_bitz/utils/constants.dart';
import 'package:show_bitz/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:show_bitz/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, dynamic>> loadMovies() async {
    const url =
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";

    var response = await http.get(Uri.parse(url), headers: <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: authToken,
    });

    dynamic resp = jsonDecode(response.body);

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: FutureBuilder(
          future: loadMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                height: 120,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var item = snapshot.data?['results'];
                    print(item);
                    print('----------------------------------');
                    // return MovieCard(title: title,);
                    return const Text(
                      "Movie",
                    );
                  },
                  itemCount: snapshot.data?['results'].length,
                  scrollDirection: Axis.horizontal,
                ),
              );
            }

            return Column(
              children: [
                Text(
                  "Now Playing",
                  style: headerStyle,
                )
              ],
            );
          },
        ));
  }
}
