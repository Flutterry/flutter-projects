import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final double width, height;
  final int value;

  Cell(this.width, this.height, this.value);

  Color getColor() {
    switch (value) {
      case 0:
        return Colors.red;
        break;
      case 1:
        return Colors.yellowAccent;
        break;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getColor(),
        ),
      ),
    );
  }
}
