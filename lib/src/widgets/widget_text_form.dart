import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextInputType keyBoardType;
  final TextEditingController controller;
  final Function(String) validate;
  final FocusNode nextFocus, focus;

  TextForm({
    @required this.label,
    @required this.icon,
    @required this.keyBoardType,
    this.controller,
    @required this.validate,
    this.nextFocus,
    this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          focusNode: focus,
          keyboardType: keyBoardType,
          controller: controller,
          validator: validate,
          onFieldSubmitted: (value) {
            if (nextFocus != null) nextFocus.requestFocus();
          },
          obscureText: keyBoardType == TextInputType.visiblePassword,
          decoration: InputDecoration(
              isCollapsed: true,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              labelText: label,
              prefixIcon: Icon(icon),
              border: OutlineInputBorder()),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
