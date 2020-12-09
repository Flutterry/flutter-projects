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

double bestRestaurantHeight(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.4;

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

double height(BuildContext context, double persentage) =>
    MediaQuery.of(context).size.height * persentage;

void nav(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void navClear(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

bool valid(String regex, String value) {
  var result = RegExp(regex).hasMatch(value);
  return result;
}

void showSnakbar(GlobalKey<ScaffoldState> key, String msg) {
  // ignore: deprecated_member_use
  key.currentState.showSnackBar(
    SnackBar(content: Text(msg)),
  );
}

///default ext = png
String image(String imageName, [String ext = 'png']) =>
    'assets/images/$imageName.$ext';

String emailRegx = '^[1-9a-zA-Z_]{3,}@[a-zA-Z]{2,}\\.com\$';
String passwordRegx = '[a-zA-Z1-9_]{8,}';

var pobFood = <Food>[
  Food(
      name: 'some food',
      image: image('1', 'jpg'),
      price: 12.99,
      rate: 4.7,
      fav: false,
      peopleRating: 200,
      restaurentId: 'Pizza hut'),
  Food(
      name: 'some food',
      image: image('3', 'jpg'),
      price: 12.99,
      rate: 4,
      fav: false,
      peopleRating: 200,
      restaurentId: 'Pizza hut'),
  Food(
      name: 'some food',
      image: image('5', 'jpg'),
      price: 12.99,
      rate: 4.7,
      fav: true,
      peopleRating: 200,
      restaurentId: 'Pizza hut'),
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
      restaurentId: 'Pizza hut'),
  Food(
      name: 'some food',
      image: image('sf', 'jpg'),
      price: 12.99,
      rate: 4.7,
      fav: false,
      peopleRating: 200,
      restaurentId: 'Pizza hut'),
  Food(
      name: 'some food',
      image: image('pizza', 'jpg'),
      price: 12.99,
      rate: 4.7,
      fav: true,
      peopleRating: 200,
      restaurentId: 'Pizza hut'),
];
