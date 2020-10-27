import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screens/screens.dart';
import 'package:flutter_projects/src/utils/palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var _screens = [
    Home(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  var _icons = [
    Icons.home,
    MdiIcons.videoOutline,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu,
  ];

  var _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedScreen,
          children: _screens,
        ),
        bottomNavigationBar: _buildNavigationBar(),
      ),
    );
  }

  _buildNavigationBar() => TabBar(
        onTap: (index) {
          setState(() {
            _selectedScreen = index;
          });
        },
        indicator: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 3,
          color: Palette.facebookBlue,
        ))),
        tabs: _icons.asMap().keys.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Icon(
              _icons[e],
              size: 25,
              color: e == _selectedScreen
                  ? Palette.facebookBlue
                  : Colors.grey[600],
            ),
          );
        }).toList(),
      );
}
