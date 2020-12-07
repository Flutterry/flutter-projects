import 'package:flutter/material.dart';
import '../model/models.dart';
import '../utils.dart';
import '../widget/widgets.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    @required this.category,
    @required this.onPress,
  });

  final Category category;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: lightRed,
                    offset: Offset(4, 6),
                    blurRadius: 6,
                  )
                ],
              ),
              child: Image.asset(category.image),
            ),
          ),
          SizedBox(height: 3),
          CustomTitle(
            text: category.name,
            size: 12,
            color: black,
          )
        ],
      ),
    );
  }
}
