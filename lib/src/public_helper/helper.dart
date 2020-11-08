import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xffF1F1F0);
const Color darkColor = Color(0xff6941B2);

void push(context, screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

void pushClear(context, screen) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => screen), (route) => false);

void pushReplacement(context, screen) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => screen));

void pop(context) => Navigator.pop(context);

bool validation(String source, String value) {
  var regex = RegExp(source, caseSensitive: false);
  var matches = regex.allMatches(value);
  for (var match in matches)
    if (match.start == 0 && match.end == value.length) return true;
  return false;
}

String emailValidation(value) {
  var valid = validation('[a-zA-Z0-9_]+@.+\\.com', value);
  return !valid ? 'please enter a valid email' : null;
}

String passwordValidation(value) {
  var valid = validation('[0-9a-zA-Z_]{8,}', value);
  return !valid ? 'please enter valid password at least 8 chars' : null;
}

void showMsg(BuildContext context, String title, String msg) {
  EdgeAlert.show(
    context,
    icon: Icons.notifications,
    description: msg,
    title: title,
    gravity: EdgeAlert.TOP,
    backgroundColor: darkColor,
    duration: EdgeAlert.LENGTH_LONG,
  );
}
