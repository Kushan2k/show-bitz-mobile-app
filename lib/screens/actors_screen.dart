import 'package:flutter/material.dart';
import 'package:show_bitz/services/actor_service.dart';
import 'package:show_bitz/utils/actor.dart';

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Popular Now")],
          ),
          FutureBuilder(
            future: ActorService.loadActors(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var item = snapshot.data?[index];

                        if (item == null) {
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

                        Actor acotr = Actor.fromMap(item);

                        print(acotr.img);

                        return const Text(
                          "hello",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      },
                      itemCount: snapshot.data?.length,
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
