import 'package:flutter/material.dart';
import 'screens.dart';
import '../utils.dart';

class Navigation extends StatefulWidget {
  @override
  State createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var screens = <Widget>[
    Home(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        currentIndex: currentPage,
        elevation: 0,
        selectedItemColor: red,
        unselectedItemColor: grey,
        items: bottomItems.entries
            .map((e) =>
                BottomNavigationBarItem(icon: Icon(e.key), label: e.value))
            .toList(),
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
