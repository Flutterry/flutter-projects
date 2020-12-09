import 'package:flutter/material.dart';
import 'package:flutter_projects/src/utils.dart';
import 'package:flutter_projects/src/widget/custom_title.dart';
import 'package:flutter_projects/src/widget/widgets.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        title: CustomTitle(
          text: 'Shopping Bag ',
          color: black,
          size: 20,
        ),
        actions: [
          ShoppingIcon(
            items: 3,
            onPress: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pobFood.length,
        itemBuilder: (context, index) {
          var food = pobFood[index];
          return ShoppingFoodCard(
            context: context,
            food: food,
            add: () {
              //TODO increment
            },
            remove: () {
              //TODO decrement
            },
            delete: () {
              //TODO remove from bag
            },
          );
        },
      ),
    );
  }
}
