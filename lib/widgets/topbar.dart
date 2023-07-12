import 'package:flutter/material.dart';

AppBar createAppBar({required String title}) {
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
    actions: const [
      IconButton(
        onPressed: null,
        icon: Icon(
          Icons.search_outlined,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: null,
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      )
    ],
  );
}
