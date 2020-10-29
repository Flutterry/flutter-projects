import 'package:flutter/material.dart';

void push(
  BuildContext context,
  Widget screen,
) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void pushReplacement(
  BuildContext context,
  Widget screen,
) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}
