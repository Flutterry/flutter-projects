import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xff153DD1),
      ),
      home: SplashScreen(),
    );
  }
}
