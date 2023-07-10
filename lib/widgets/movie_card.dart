import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String img;
  final int index;

  const MovieCard({
    super.key,
    required this.title,
    required this.img,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('taped');
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: index == 0
              ? const EdgeInsets.only(
                  left: 0,
                  top: 10,
                  bottom: 10,
                  right: 5,
                )
              : const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                img,
                alignment: Alignment.center,
                width: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
