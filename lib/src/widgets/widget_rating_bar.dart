import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRating extends StatelessWidget {
  final int rate;

  MyRating(this.rate);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      onRatingUpdate: (rate) {},
      allowHalfRating: false,
      itemCount: 5,
      itemSize: 15,
      initialRating: rate.toDouble(),
      glow: true,
      ignoreGestures: true,
      ratingWidget: RatingWidget(
        full: Icon(Icons.star, color: Color(0xffF3A420)),
        empty: Icon(Icons.star_outline, color: Color(0xffF3A420)),
        half: Icon(Icons.star, color: Colors.grey),
      ),
    );
  }
}
