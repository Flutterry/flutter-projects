import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

void showMsg(BuildContext context, String title, String msg) {
  EdgeAlert.show(
    context,
    title: title,
    description: msg,
    backgroundColor: Palette.darkColor,
    icon: Icons.error_outline,
    duration: EdgeAlert.LENGTH_VERY_LONG,
    gravity: EdgeAlert.TOP,
  );
}
