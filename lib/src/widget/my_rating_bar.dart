import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

import '../utils.dart';

class MyRatingBar extends StatelessWidget {
  const MyRatingBar({
    Key key,
    @required this.rate,
  }) : super(key: key);

  final double rate;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      size: 10,
      onRatingChanged: (double rating) {},
      emptyIcon: Icons.favorite_border,
      filledIcon: Icons.favorite,
      emptyColor: red,
      filledColor: red,
      halfFilledColor: red,
      initialRating: rate,
      isHalfAllowed: false,
      maxRating: 5,
    );
  }
}
