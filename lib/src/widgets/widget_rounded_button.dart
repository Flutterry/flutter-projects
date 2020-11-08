import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPress;

  final String title;
  final Color titleColor, backgroundColor;

  RoundedButton(
      {this.onPress, this.title, this.titleColor, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPress,
        color: backgroundColor,
        child: Text(title, style: TextStyle(fontSize: 14, color: titleColor)),
      ),
    );
  }
}
