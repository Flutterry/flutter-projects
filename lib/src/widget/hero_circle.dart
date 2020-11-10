import 'package:flutter/material.dart';

class HeroCircle extends StatelessWidget {
  final double radius;
  final String heroTag;
  final Color color;
  final Type type;

  const HeroCircle({this.radius, this.heroTag, this.color, this.type});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Positioned(
      left: type == Type.bottom
          ? 0
          : type == Type.top
              ? radius * -1
              : null,
      top: type == Type.bottom
          ? deviceSize.height / 2
          : type == Type.top
              ? radius * -1
              : type == Type.centerRight
                  ? deviceSize.height / 2 - radius
                  : deviceSize.height - radius,
      right: type == Type.centerRight ? radius * -1 : type == Type.bottomSmall ? radius * -1: null,
      child: Hero(
        tag: heroTag,
        child: CircleAvatar(
          backgroundColor: color,
          radius: radius,
        ),
      ),
    );
  }
}

enum Type {
  bottom,
  bottomSmall,
  top,
  centerRight,
}
