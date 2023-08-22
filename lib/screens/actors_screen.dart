import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_bitz/screens/threanding_screen.dart';
import 'package:show_bitz/services/actor_service.dart';
import 'package:show_bitz/utils/actor.dart';
import 'package:show_bitz/utils/styles.dart';

class ActorsScreen extends StatefulWidget {
  const ActorsScreen({super.key});

  @override
  State<ActorsScreen> createState() => _ActorsScreenState();
}

class _ActorsScreenState extends State<ActorsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Expanded(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Popular Now",
                  style: headerStyle,
                ),
              )
            ],
          ),
          FutureBuilder(
            future: ActorService.loadActors(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      itemCount: snapshot.data?.length,
                      padding: const EdgeInsets.all(10),
                      physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast,
                      ),
                      cacheExtent: 10,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        Actor actor = Actor.fromMap(snapshot.data![index]);

                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                // aspectRatio: 1.0,
                                height: MediaQuery.of(context).size.height / 3,
                                child: CachedNetworkImage(
                                  imageUrl: actor.img,
                                  fit: BoxFit.contain,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Center(
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
                              ),
                              const SizedBox(height: 8),
                              Text(
                                actor.name.capitalize(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                case ConnectionState.waiting:
                  return showProgressIndicator();
                default:
                  return showProgressIndicator();
              }
            },
          )
        ],
      )),
    ));
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
