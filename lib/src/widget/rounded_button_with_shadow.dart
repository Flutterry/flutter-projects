import 'dart:io';

import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widget/widgets.dart';

class RoundedButton extends StatelessWidget {
  final Color textColor, backgroundColor;
  final String text;
  final void Function() onPress;

  RoundedButton({
    this.textColor = Colors.white,
    this.backgroundColor = Palette.darkColor,
    @required this.text,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: backgroundColor,
          child: InkWell(
            onTap: onPress,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: TextShadow(
                text: text,
                textColor: textColor,
                fontSize: 20,
                bold: false,
              )),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: textColor.withOpacity(.4)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.blueGrey[900], blurRadius: 5, offset: Offset(1,2))
        ]
      ),
    );
  }
}
