import 'package:flutter/material.dart';
import '../utils.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final void Function() onTap;

  const IconCard({this.icon, this.iconColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: lightGrey, blurRadius: 4, offset: Offset(1, 1))
            ]),
        child: Icon(
          icon,
          color: iconColor,
          size: 15,
        ),
      ),
    );
  }
}
