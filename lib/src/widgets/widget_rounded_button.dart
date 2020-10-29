import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function() onPress;

  final String title;
  final Color backgroundColor;
  final Color fontColor;

  RoundedButton({
    @required this.onPress,
    @required this.title,
    @required this.backgroundColor,
    @required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: onPress,
        textColor: fontColor,
        child: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
