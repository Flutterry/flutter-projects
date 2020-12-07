import 'package:flutter/material.dart';
import '../utils.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  const CustomTitle({
    @required this.text,
    this.size = 16.0,
    this.color = black,
    this.weight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
