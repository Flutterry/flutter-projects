import 'package:flutter/material.dart';
import 'model/models.dart';

const Color red = Colors.red;
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;
Color lightGrey = Colors.grey[300];
Color lightRed = Colors.red[50];

const String applicationTitle = 'Foody';

double appBarHeight(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.28;

double pobFoodHeight(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.4;

double bestFoodHeight(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.4;

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

///default ext = png
String image(String imageName, [String ext = 'png']) =>
    'assets/images/$imageName.$ext';

var categories = <Category>[
  Category(name: 'salad', image: image('salad')),
  Category(name: 'steak', image: image('steak')),
  Category(name: 'fast food', image: image('sandwich')),
  Category(name: 'desert', image: image('ice-cream')),
  Category(name: 'sea food', image: image('fish')),
  Category(name: 'drink', image: image('pint')),
];

var pobFood = <Food>[
  Food(
    name: 'some food',
    image: image('1', 'jpg'),
    price: 12.99,
    rate: 4.7,
    fav: false,
    peopleRating: 200,
  ),
  Food(
    name: 'some food',
    image: image('3', 'jpg'),
    price: 12.99,
    rate: 4,
    fav: false,
    peopleRating: 200,
  ),
  Food(
    name: 'some food',
    image: image('5', 'jpg'),
    price: 12.99,
    rate: 4.7,
    fav: true,
    peopleRating: 200,
  ),
];

Map<IconData, String> bottomItems = {
  Icons.home: 'Home',
  Icons.location_on: 'Near by',
  Icons.shop: 'Cart',
  Icons.account_circle: 'Account',
};

var bestFoodList = <Food>[
  Food(
      name: 'some food',
      image: image('food', 'jpg'),
      price: 12.99,
      rate: 4.7,
      fav: true,
      peopleRating: 200,
      from: 'Pizza hut'),
  Food(
      name: 'some food',
      image: image('sf', 'jpg'),
      price: 12.99,
      rate: 4.7,
      fav: false,
      peopleRating: 200,
      from: 'Pizza hut'),
  Food(
      name: 'some food',
      image: image('pizza', 'jpg'),
      price: 12.99,
      rate: 4.7,
      fav: true,
      peopleRating: 200,
      from: 'Pizza hut'),
];
