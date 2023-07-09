import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  const MovieCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
        ),
      ),
    );
  }
}
