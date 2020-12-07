import 'package:flutter/material.dart';
import '../utils.dart';

class Search extends StatelessWidget {
  const Search({
    @required this.hint,
    @required this.leftIcon,
    @required this.rightIcon,
    @required this.onSubmitSearch,
    @required this.filtterFunction,
  });

  final String hint;
  final IconData leftIcon, rightIcon;
  final void Function(String) onSubmitSearch;
  final void Function() filtterFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: lightGrey,
            offset: Offset(1, 1),
            blurRadius: 4,
          )
        ],
      ),
      child: ListTile(
        leading: Icon(leftIcon, color: red),
        title: TextField(
          onSubmitted: onSubmitSearch,
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        ),
        trailing: GestureDetector(
          onTap: filtterFunction,
          child: Icon(rightIcon, color: red),
        ),
      ),
    );
  }
}
