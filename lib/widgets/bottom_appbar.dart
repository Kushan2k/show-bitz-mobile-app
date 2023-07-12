import 'package:flutter/material.dart';

Widget bottomNavBar({required int index, required Function tap}) {
  const activeColor = Colors.green;
  return BottomNavigationBar(
    backgroundColor: Colors.transparent,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white54,
    onTap: (value) {
      tap(value);
    },
    currentIndex: index,
    items: [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: '',
        activeIcon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: activeColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: const Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.video_call),
        label: '',
        activeIcon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: activeColor,
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.video_call,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.bookmark),
        label: '',
        activeIcon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: activeColor,
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.bookmark,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.list),
        label: '',
        activeIcon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: activeColor,
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.list,
          ),
        ),
      ),
    ],
  );
}
