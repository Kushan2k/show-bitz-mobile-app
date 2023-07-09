import 'package:flutter/material.dart';
import 'package:show_bitz/screens/home_screen.dart';
import 'package:show_bitz/utils/colors.dart';
import 'package:show_bitz/widgets/bottom_appbar.dart';
import 'package:show_bitz/widgets/topbar.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final pages = const [
    HomeScreen(),
    Text("Hello 2"),
    Text("Hello 3"),
    Text("Hello 4"),
  ];
  int index = 0;

  void changePage(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: createAppBar(
          title: "Show Bitz",
        ),
        bottomNavigationBar: bottomNavBar(
          index: index,
          tap: changePage,
        ),
        backgroundColor: backgroundColor,
        body: pages[index],
      ),
    );
  }
}
