import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_bitz/utils/constants.dart';
import 'package:show_bitz/utils/styles.dart';
import 'package:http/http.dart' as http;

class ThreandingScreen extends StatefulWidget {
  const ThreandingScreen({super.key});

  @override
  State<ThreandingScreen> createState() => _ThreandingScreenState();
}

class _ThreandingScreenState extends State<ThreandingScreen> {
  Future<List?> getThreandingThisWeek() async {
    const url = "https://api.themoviedb.org/3/trending/all/week?language=en-US";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      // print(resp);
      return resp;
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                  "Thrending this week",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: getThreandingThisWeek(),
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
                          // height: MediaQuery.of(context).size.height,
                          height: 600,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var item = snapshot.data;
                              try {
                                String title;
                                String type = item![index]['media_type'];
                                if (type == 'movie') {
                                  title = item[index]['title'];
                                } else {
                                  title = item[index]['name'];
                                }
                                int id = item[index]['id'];
                                double rate = item[index]['vote_average'];
                                String imgpath = item[index]['poster_path'];
                                return ThreandingItem(
                                  title: title,
                                  type: type,
                                  id: id,
                                  imgpath: imgpath,
                                  rate: rate,
                                );
                              } catch (er) {
                                return const Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.white,
                                  ),
                                );
                              }
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

class ThreandingItem extends StatelessWidget {
  final String title;
  final String type;
  final int id;
  final String imgpath;
  final double rate;
  const ThreandingItem({
    super.key,
    required this.title,
    required this.type,
    required this.id,
    required this.imgpath,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String url = 'https://image.tmdb.org/t/p/original$imgpath';
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: width - 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    width: 400,
                    fit: BoxFit.fill,
                    imageUrl: url,
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Positioned(
                      left: 10,
                      top: 10,
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                type.capitalize(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                                    double.parse(rate.toString())
                                        .toStringAsFixed(1),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
