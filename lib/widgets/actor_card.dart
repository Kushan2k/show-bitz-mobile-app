import 'package:flutter/material.dart';

class Actor extends StatelessWidget {
  const Actor({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 5,
      child: const Column(
        children: [
          Text("Actor"),
          Text("Actor"),
        ],
      ),
    );
  }
}
