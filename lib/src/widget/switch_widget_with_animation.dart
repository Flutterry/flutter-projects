import 'package:flutter/material.dart';

class SwitchedWidget extends StatelessWidget {
  final Widget child1, child2;
  final bool isFirst;

  SwitchedWidget(
    this.child1,
    this.child2,
    this.isFirst,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: isFirst ? child1 : child2,
      duration: Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return ScaleTransition(child: child, scale: animation);
      },
    );
  }
}
