import 'package:flutter/material.dart';

class Food {
  final String name, image, from;
  final bool fav;
  final double price, rate;
  final int peopleRating;

  Food({
    @required this.name,
    @required this.image,
    @required this.fav,
    @required this.price,
    @required this.rate,
    @required this.peopleRating,
    @required this.from,
  });
}
