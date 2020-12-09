import 'package:flutter/material.dart';
import '../utils.dart';
import '../widget/widgets.dart';

class ShoppingIcon extends StatelessWidget {
  const ShoppingIcon({
    Key key,
    @required this.items,
    @required this.onPress,
  }) : super(key: key);

  final int items;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    String getText() => items > 9 ? '+9' : items.toString();
    var shoppingIcon = Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.shopping_cart_outlined,
          color: red,
        ));

    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            shoppingIcon,
            items == 0
                ? SizedBox.shrink()
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: lightGrey,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: CustomTitle(
                        text: getText(),
                        size: 14,
                        color: red,
                        weight: FontWeight.w400,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
