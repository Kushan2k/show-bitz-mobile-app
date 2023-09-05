import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:show_bitz/services/actor_service.dart';

import 'package:show_bitz/utils/colors.dart';

class PersonDetailsScreen extends StatelessWidget {
  final int id;
  const PersonDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: FutureBuilder(
          future: ActorService.loadActorDetails(id: id),
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

                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Stack(children: [
                          CachedNetworkImage(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            imageUrl:
                                "https://image.tmdb.org/t/p/original${item['profile_path']}",
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
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                item['known_for_department'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                item['birthday'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                item['place_of_birth'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                item['biography'],
                                maxLines: 25,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: FutureBuilder(
                            future: ActorService.getImages(id: id),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.done:
                                  var data = snapshot.data;

                                  print(snapshot.data);

                                  if (data == null) {
                                    return const Center(
                                      child: Icon(
                                        Icons.error,
                                        size: 25,
                                      ),
                                    );
                                  }

                                  return SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      itemCount: data?.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var item = data[index];

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.contain,
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/original${item['file_path']}",
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) {
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: SizedBox(
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
                                                ),
                                              );
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                case ConnectionState.waiting:
                                  return showProgress();
                                default:
                                  return showProgress();
                              }
                            },
                          ),
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
