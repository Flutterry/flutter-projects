import 'package:flutter/material.dart';

import 'text_with_shadow.dart';

class ClickableColumnText extends StatelessWidget {
  final String text1, text2;
  final Color color1, color2;
  final void Function() onPress;

  ClickableColumnText(
      this.text1, this.text2, this.color1, this.color2, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextShadow(
        text: text1,
        textColor: color1,
        fontSize: 20,
      ),
      GestureDetector(
        onTap: onPress,
        child: TextShadow(
          text: text2,
          textColor: color2,
          fontSize: 20,
          underLine: true,
        ),
      ),
    ]);
  }
}
