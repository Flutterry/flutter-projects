import 'package:flutter/material.dart';
import '../model/models.dart';
import '../widget/widgets.dart';
import '../utils.dart';

class ShoppingFoodCard extends StatelessWidget {
  const ShoppingFoodCard({
    Key key,
    @required this.context,
    @required this.food,
    @required this.add,
    @required this.remove,
    @required this.delete,
  }) : super(key: key);

  final BuildContext context;
  final Food food;
  final void Function() add;
  final void Function() remove;
  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      width: double.infinity,
      height: height(context, .15),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: lightRed, offset: Offset(3, 3), blurRadius: 5)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                food.image,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTitle(
                    text: food.name,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  CustomTitle(
                    text: '\$${food.price.toStringAsFixed(2)}',
                    size: 18,
                    weight: FontWeight.w300,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(icon: Icon(Icons.delete), onPressed: delete),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.remove), onPressed: remove),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: red, borderRadius: BorderRadius.circular(4)),
                    child: CustomTitle(
                      text: '1',
                      color: white,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: red,
                      ),
                      onPressed: add)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
