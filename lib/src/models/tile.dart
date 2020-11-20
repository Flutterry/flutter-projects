import 'package:flutter/material.dart';

class Tile {
  double x;
  double y;
  int value;

  Tile(this.x, this.y, this.value) {
   resetAnimation();
  }

  void resetAnimation(){
    animationX = AlwaysStoppedAnimation(x);
    animationY = AlwaysStoppedAnimation(y);
    fontSize = AlwaysStoppedAnimation(1);
  }

  Animation<double> animationX;
  Animation<double> animationY;

  void startMovingTo(AnimationController parent, double x, double y) {
    animationX = Tween(begin: this.x, end: x).animate(parent);
    animationY = Tween(begin: this.y, end: y).animate(parent);
  }

  Animation<double> fontSize;

  void startChangeFontSize(AnimationController parent) {
    fontSize = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.8),
        weight: 1
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.8, end: 1.0),
        weight: 1
      ),
    ]).animate(parent);
  }
}
