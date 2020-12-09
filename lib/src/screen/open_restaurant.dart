import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/model/models.dart';
import 'package:flutter_projects/src/screen/screens.dart';
import 'package:flutter_projects/src/utils.dart';
import 'package:flutter_projects/src/widget/icon_card.dart';
import 'package:flutter_projects/src/widget/shopping_icon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OpenRestaurant extends StatefulWidget {
  final Restaurant restaurant;
  OpenRestaurant({this.restaurant});
  @override
  _OpenRestaurantState createState() => _OpenRestaurantState();
}

class _OpenRestaurantState extends State<OpenRestaurant> {
  Restaurant get restaurant => widget.restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    height: height(context, 0.3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: restaurant.image,
                      placeholder: (context, text) => SpinKitFadingCube(
                        color: red,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconCard(
                        icon: Icons.clear,
                        iconColor: red,
                        onTap: () => pop(context),
                      ),
                      ShoppingIcon(
                          items: 3,
                          onPress: () {
                            nav(context, Shopping());
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
