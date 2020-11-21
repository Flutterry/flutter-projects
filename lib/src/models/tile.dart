import 'package:flutter/material.dart';

class Tile {
  double x;
  double y;
  int value;

  Tile(this.x, this.y, this.value) {
   resetAnimation();
  }

  void resetAnimation(){
    fontSize = AlwaysStoppedAnimation(1);
    appear = AlwaysStoppedAnimation(1.0);
  }

  Animation<double> appear;

  void startAppear(AnimationController parent){
    appear = Tween(begin: 0.0, end: 1.0).animate(parent);
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
