import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'screen/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: Palette.scaffoldColor),
      home: GetStarted(),
    );
  }
}
