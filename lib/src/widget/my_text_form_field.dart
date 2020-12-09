import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key key,
    @required this.controller,
    @required this.lable,
    @required this.errorMessage,
    @required this.icon,
    @required this.keyboardType,
    @required this.validation,
    this.nextNode,
    this.myNode,
  }) : super(key: key);

  final String lable, errorMessage;
  final IconData icon;
  final TextInputType keyboardType;
  final bool Function(String p1) validation;
  final TextEditingController controller;
  final FocusNode myNode, nextNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: TextFormField(
        focusNode: myNode,
        controller: controller,
        maxLines: 1,
        obscureText: (keyboardType == TextInputType.visiblePassword),
        decoration: InputDecoration(
          labelText: lable,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        onFieldSubmitted: (value) {
          nextNode?.requestFocus();
        },
        validator: (value) {
          var valid = validation(value);
          return !valid ? errorMessage : null;
        },
      ),
    );
  }
}
