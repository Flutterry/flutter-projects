import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;

  CircleButton({this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        iconSize: 30,
      ),
    );
  }
}
