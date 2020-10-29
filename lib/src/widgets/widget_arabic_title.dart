import 'package:flutter/material.dart';

class ArabicTitle extends StatelessWidget {
  final String text;
  final double size;
  final bool isBold;
  final Color color;
  final bool withLine;

  ArabicTitle({
    this.withLine,
    @required this.text,
    @required this.size,
    @required this.isBold,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: size,
          decorationThickness: 2,
          decorationColor: Colors.black,
          decoration: withLine == true
              ? TextDecoration.lineThrough
              : TextDecoration.none),
      textDirection: TextDirection.rtl,
    );
  }
}
