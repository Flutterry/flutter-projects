import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screens/screens.dart';
import 'package:flutter_projects/src/utils/palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: NavigationScreen(),
    );
  }
}
