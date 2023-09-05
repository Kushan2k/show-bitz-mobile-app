import 'package:flutter/material.dart';
import 'package:show_bitz/screens/search_screen.dart';

AppBar createAppBar({required String title, required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.black,
    title: Text(
      title,
      style: const TextStyle(
        letterSpacing: 5,
        shadows: [
          Shadow(
            blurRadius: 10,
            color: Colors.white12,
          ),
        ],
        color: Colors.white,
        fontSize: 25,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ));
        },
        icon: const Icon(
          Icons.search_outlined,
          color: Colors.white,
        ),
      ),
      const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      )
    ],
  );
}
