import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/public_function.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  MyAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => pop(context),
          ),
          Expanded(
            child: Center(
                child: ArabicTitle(
              text: title,
              size: 20,
              isBold: true,
              color: Colors.white,
            )),
          )
        ],
      ),
    );
  }
}
