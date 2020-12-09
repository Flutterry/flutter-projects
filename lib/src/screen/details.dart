import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/service/restaurant_services.dart';

import 'screens.dart';
import '../utils.dart';
import '../widget/widgets.dart';
import '../model/models.dart';

class Details extends StatefulWidget {
  final Food food;

  const Details({this.food});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Food get food => widget.food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: foodImageSlider(food),
            ),
            SliverToBoxAdapter(child: foodBasicDetails()),
            SliverToBoxAdapter(
              child: addToShopping(),
            )
          ],
        ),
      ),
    );
  }

  Widget addToShopping() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            //TODO
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: red, borderRadius: BorderRadius.circular(4)),
            child: CustomTitle(
              text: 'Add To Bag',
              color: white,
            ),
          ),
        ),
      ],
    );
  }

  Widget foodBasicDetails() {
    return ListTile(
      title: CustomTitle(
        text: food.name,
        size: 20,
        weight: FontWeight.bold,
      ),
      subtitle: FutureBuilder(
        future:
            RestaurantServices.instance().getRestaurantById(food.restaurentId),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return SizedBox.shrink();
          var restaurant = Restaurant.fromSnapshot(snapshot.data);
          return Row(
            children: [
              CustomTitle(text: 'by: ', size: 13),
              GestureDetector(
                onTap: () {
                  //TODO open restaurant
                },
                child: CustomTitle(
                  text: restaurant.name,
                  size: 15,
                  weight: FontWeight.w400,
                ),
              ),
            ],
          );
        },
      ),
      trailing: CustomTitle(
        text: '\$${food.price.toStringAsFixed(2)}',
        weight: FontWeight.bold,
      ),
    );
  }

  Widget foodImageSlider(Food food) {
    return Stack(
      children: [
        Container(
          height: height(context, .4),
          child: Carousel(
            images: [
              CachedNetworkImageProvider(food.image),
              CachedNetworkImageProvider(food.image),
              CachedNetworkImageProvider(food.image),
            ],
            dotIncreasedColor: red,
            autoplay: false,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: red,
                ),
                onPressed: () => pop(context)),
            ShoppingIcon(
              items: 5,
              onPress: () {
                nav(context, Shopping());
              },
            ),
          ],
        ),
        Positioned(
          bottom: height(context, .1),
          right: 20,
          child: IconCard(
            icon: food.fav ? Icons.favorite : Icons.favorite_border,
            iconColor: red,
            onTap: () {
              //TODO add to favorite items
            },
          ),
        )
      ],
    );
  }
}
