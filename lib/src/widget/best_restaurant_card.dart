import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../model/models.dart';
import 'widgets.dart';
import '../utils.dart';

class BestRestaurantCard extends StatelessWidget {
  const BestRestaurantCard({
    Key key,
    @required this.restaurant,
    @required this.onPress,
  }) : super(key: key);

  final Restaurant restaurant;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
            height: bestRestaurantHeight(context),
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: restaurant.image,
                fit: BoxFit.cover,
                placeholder: (_, text) => SpinKitCircle(color: red),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
            height: bestRestaurantHeight(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  SizedBox(width: 5),
                  CustomTitle(
                    text: '${restaurant.rate}',
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  text: '${restaurant.name}',
                  size: 20,
                  weight: FontWeight.bold,
                  color: white,
                ),
                Row(
                  children: [
                    CustomTitle(
                      text: 'average meal price :  ',
                      color: white,
                    ),
                    CustomTitle(
                      text: '\$${restaurant.avgPrice.toStringAsFixed(2)}',
                      size: 20,
                      weight: FontWeight.bold,
                      color: white,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
