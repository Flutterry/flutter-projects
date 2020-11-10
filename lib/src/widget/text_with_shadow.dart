import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextShadow extends StatelessWidget {
  final Color textColor;
  final String text;
  final double fontSize;
  final bool bold, underLine;

  TextShadow({
    this.textColor = Colors.black,
    @required this.text,
    this.bold = true,
    this.fontSize = 14,
    this.underLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          decorationThickness: 2,
          decoration: underLine ? TextDecoration.underline: TextDecoration.none,
          shadows: [
            Shadow(
              color: Colors.blueGrey.withOpacity(.7),
              blurRadius: 10,
              offset: Offset(2, 5),
            )
          ],
          fontWeight: bold? FontWeight.w900: FontWeight.normal),
    );
  }
}
