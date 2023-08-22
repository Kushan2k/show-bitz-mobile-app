import 'package:flutter/material.dart';
import 'package:show_bitz/services/series_service.dart';
import 'package:show_bitz/utils/series.dart';
import 'package:show_bitz/utils/styles.dart';
import 'package:show_bitz/utils/video.dart';
import 'package:show_bitz/widgets/movie_card.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
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
                      "Tv shows",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "On Air Today",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: SeriesService.loadToday(),
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
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Opps! loading failed\nPlease make sure your connection is up",
                                      style: TextStyle(color: Colors.white60),
                                    ),
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
                              Video s = Series.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                video: s,
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
                  "This Week",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: SeriesService.loadThisWeekThreanding(),
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
                              Series s = Series.fromMap(snapshot.data?[index]);
                              return MovieCard(
                                video: s,
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
                  "Popular",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: SeriesService.loadPopularSeries(),
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
                              Video s = Series.fromMap(snapshot.data?[index]);

                              return MovieCard(
                                video: s,
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
                  "Top Rated",
                  style: headerStyle,
                ),
                FutureBuilder(
                  future: SeriesService.loadTopRated(),
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
                          height: 340,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Series m = Series.fromMap(snapshot.data?[index]);

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
