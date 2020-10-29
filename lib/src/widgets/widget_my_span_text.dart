import 'package:flutter/material.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class MySpanText extends StatelessWidget {
  final String normalText;
  final String clickableText;
  final Function onPress;

  MySpanText(this.normalText, this.clickableText, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPress,
          child: ArabicTitle(
            text: clickableText,
            size: 14,
            color: Theme.of(context).scaffoldBackgroundColor,
            isBold: true,
          ),
        ),
        SizedBox(width: 5),
        ArabicTitle(
          text: normalText,
          size: 14,
          color: Colors.black,
          isBold: true,
        ),
      ],
    );
  }
}
