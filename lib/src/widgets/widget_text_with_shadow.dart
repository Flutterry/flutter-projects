import 'package:flutter/material.dart';

class TextShadow extends StatelessWidget {
  final String title;
  final double fontSize;

  TextShadow({@required this.title, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          shadows: [
            Shadow(color: Colors.grey, offset: Offset(0, 4), blurRadius: 15),
          ],
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[900]),
    );
  }
}
