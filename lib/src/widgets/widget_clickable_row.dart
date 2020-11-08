import 'package:flutter/material.dart';

class ClickableRow extends StatelessWidget {
  final String title1, title2;
  final Function onPress;

  ClickableRow({this.title1, this.title2, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title1),
        SizedBox(width: 10),
        GestureDetector(
          onTap: onPress,
          child: Text(
            title2,
            style: TextStyle(
                shadows: [
                  Shadow(
                      color: Colors.grey, offset: Offset(0, 4), blurRadius: 15),
                ],
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[900],
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
