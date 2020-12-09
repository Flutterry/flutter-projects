import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/models.dart';
import 'widgets.dart';
import '../utils.dart';

class PobFoodCard extends StatelessWidget {
  const PobFoodCard({
    @required this.food,
    @required this.onPress,
  });

  final Food food;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        height: double.infinity,
        width: deviceWidth(context) * .6,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(color: lightRed, offset: Offset(3, 3), blurRadius: 5),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: food.image,
                      fit: BoxFit.fitWidth,
                      width: deviceWidth(context) * .6,
                      placeholder: (context, text) =>
                          SpinKitHourGlass(color: red),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitle(
                              text: food.name,
                              size: 14,
                            ),
                            Row(
                              children: [
                                CustomTitle(
                                  text: food.rate.toString(),
                                  size: 12,
                                  color: grey,
                                ),
                                SizedBox(width: 3),
                                MyRatingBar(rate: food.rate),
                                SizedBox(width: 3),
                                CustomTitle(
                                  text: '(${food.peopleRating})',
                                  size: 12,
                                  color: grey,
                                )
                              ],
                            ),
                          ],
                        ),
                        CustomTitle(
                          text: '\$${food.price.toStringAsFixed(2)}',
                          size: 12,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 10,
              top: 10,
              child: IconCard(
                icon: food.fav ? Icons.favorite : Icons.favorite_border,
                iconColor: red,
                onTap: () {
                  //TODO change data on server
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
