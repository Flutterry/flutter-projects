import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screens/screen_home.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var _screens = [
    Home(
      key: PageStorageKey('home screen'),
    ),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  var _icons = [
    Icons.home,
    Icons.search,
    Icons.queue_play_next,
    Icons.file_download,
    Icons.menu,
  ];

  var _lables = [
    'Home',
    'Search',
    'Next',
    'Download',
    'Menu',
  ];
  var _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: _icons.asMap().keys.map((e) {
          return BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(_icons[e]),
            label: _lables[e],
          );
        }).toList(),
        onTap: (index) {
          setState(() {
            _selectedScreen = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedScreen,
        showUnselectedLabels: true,
      ),
    );
  }
}
