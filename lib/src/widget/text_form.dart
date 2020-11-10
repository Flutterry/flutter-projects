import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextInputType keyboardType;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FocusNode currentNode, nextNode;
  final String Function(String) validate;

  TextForm({
    @required this.keyboardType,
    @required this.hintText,
    @required this.controller,
    @required this.validate,
    this.icon,
    this.currentNode,
    this.nextNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: validate,
        focusNode: currentNode ?? FocusNode(),
        onFieldSubmitted: (value) {
          if (nextNode != null) nextNode.requestFocus();
        },
        obscureText: keyboardType == TextInputType.visiblePassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: ' $hintText ',
            labelStyle: TextStyle(fontSize: 16),
            filled: true,
            prefixIcon: icon == null ? SizedBox.shrink() : Icon(icon),
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
      ),
    );
  }
}
