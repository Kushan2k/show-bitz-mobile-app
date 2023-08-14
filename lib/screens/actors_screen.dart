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
                        decelerationRate: ScrollDecelerationRate.normal,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) {
                        Actor actor = Actor.fromMap(snapshot.data![index]);

                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: actor.img,
                                fit: BoxFit.contain,
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
                              ),
                              Text(actor.name.capitalize()),
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

// ListView.builder(
//                       itemBuilder: (context, index) {
//                         var item = snapshot.data?[index];

//                         if (item == null) {
//                           return const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 250,
//                                 child: Center(
//                                   child: Text(
//                                     "Opps! loading failed",
//                                     style: TextStyle(color: Colors.white60),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         }

//                         Actor acotr = Actor.fromMap(item);

//                         print(acotr.img);

//                         return const Text(
//                           "hello",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         );
//                       },
//                       itemCount: snapshot.data?.length,
//                     ),
