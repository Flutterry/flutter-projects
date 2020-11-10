import 'package:flutter/material.dart';
class Nav{
  Nav._();
  static push(BuildContext context, Widget screen)=> Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  static pop(BuildContext context)=> Navigator.pop(context);
  static pushReplace(BuildContext context, Widget screen)=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen ));
  static pushClear(BuildContext context, Widget screen)=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
}