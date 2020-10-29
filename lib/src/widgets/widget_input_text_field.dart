import 'package:flutter/material.dart';

import 'widgets.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final TextInputType keyboardType;

  InputTextField({this.title, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ArabicTitle(text: title, size: 16, isBold: true, color: Colors.black),
          SizedBox(height: 7),
          TextField(
            obscureText: keyboardType == TextInputType.visiblePassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.grey[100],
                filled: true,
                isCollapsed: true),
          ),
        ],
      ),
    );
  }
}
