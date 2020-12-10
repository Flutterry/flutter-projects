import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/model/models.dart';
import 'package:flutter_projects/src/screen/screens.dart';
import 'package:flutter_projects/src/service/food_services.dart';
import 'package:flutter_projects/src/utils.dart';
import 'package:flutter_projects/src/widget/custom_title.dart';
import 'package:flutter_projects/src/widget/icon_card.dart';
import 'package:flutter_projects/src/widget/my_rating_bar.dart';
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
            SliverToBoxAdapter(child: appBar()),
            restaurantProducts(),
          ],
        ),
      ),
    );
  }

  Widget restaurantProducts() {
    return FutureBuilder(
      future: FoodServices.instance().getFoodByRestaurant(restaurant.id),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return SliverToBoxAdapter(child: SpinKitFadingCube(color: red));
        }
        var foods = <Food>[];
        for (var doc in snapshot.data.docs) {
          foods.add(Food.fromSnapshot(doc));
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var food = foods[index];
              return foodTile(food);
            },
            childCount: foods.length,
          ),
        );
      },
    );
  }

  Widget foodTile(Food food) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
      width: double.infinity,
      height: height(context, .15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: lightRed,
            offset: Offset(3, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  width: height(context, 0.15),
                  imageUrl: food.image,
                  height: height(context, 0.15),
                  fit: BoxFit.cover,
                  placeholder: (context, text) => SpinKitFoldingCube(
                    color: red,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitle(
                      text: food.name, size: 20, weight: FontWeight.bold),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTitle(
                        text: 'From',
                        size: 11,
                      ),
                      SizedBox(width: 4),
                      CustomTitle(
                        text: '${restaurant.name}',
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomTitle(
                        text: food.rate.toStringAsFixed(1),
                        color: grey,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      MyRatingBar(rate: food.rate),
                      SizedBox(width: 3),
                      CustomTitle(
                        text: '(${food.peopleRating})',
                        color: grey,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconCard(
                  icon: food.fav ? Icons.favorite : Icons.favorite_border,
                  iconColor: red,
                  onTap: () {
                    //TODO add to favorite
                  },
                ),
                CustomTitle(
                  text: '\$${food.price.toStringAsFixed(2)}',
                  weight: FontWeight.bold,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Stack(
      children: [
        Container(
          height: height(context, 0.3),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: CachedNetworkImage(
              imageUrl: restaurant.image,
              fit: BoxFit.cover,
              placeholder: (context, text) => SpinKitFadingCube(
                color: red,
              ),
            ),
          ),
        ),
        Container(
          height: height(context, 0.3),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.7),
                Colors.black.withOpacity(.6),
                Colors.black.withOpacity(.5),
                Colors.black.withOpacity(.4),
                Colors.black.withOpacity(.3),
                Colors.black.withOpacity(.2),
                Colors.black.withOpacity(.1),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconCard(
                icon: Icons.clear,
                iconColor: red,
                onTap: () => pop(context),
              ),
            ),
            ShoppingIcon(
                items: 3,
                onPress: () {
                  nav(context, Shopping());
                })
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              CustomTitle(
                  text: restaurant.name,
                  color: white,
                  size: 20,
                  weight: FontWeight.bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTitle(
                    text: 'average meal price :  ',
                    color: white,
                    size: 11,
                  ),
                  CustomTitle(
                    text: '\$${restaurant.avgPrice.toStringAsFixed(2)}',
                    size: 15,
                    weight: FontWeight.bold,
                    color: white,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.yellow[900]),
                    SizedBox(width: 5),
                    CustomTitle(
                      text: restaurant.rate.toStringAsFixed(1),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
