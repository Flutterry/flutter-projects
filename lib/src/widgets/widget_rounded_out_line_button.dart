import 'package:flutter/material.dart';

class RoundedOutLineButton extends StatelessWidget {
  final Function() onPress;

  final String title;
  final Color backgroundColor, fontColor, borderColor;
  final double borderWidth;

  RoundedOutLineButton({
    @required this.onPress,
    @required this.title,
    @required this.borderColor,
    @required this.backgroundColor,
    @required this.fontColor,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: OutlineButton(
          onPressed: onPress,
          borderSide: BorderSide(
            width: borderWidth,
            color: borderColor,
          ),
          textColor: fontColor,
          child: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
