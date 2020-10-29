import 'package:flutter/material.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class GenderSelection extends StatelessWidget {
  var _groupValue;
  final Function(dynamic) onChange;

  GenderSelection(this.onChange, this._groupValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ArabicTitle(
              text: 'الجنس', size: 20, isBold: true, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Radio(
                value: _Gender.male,
                groupValue: _groupValue,
                onChanged: onChange,
              ),
              ArabicTitle(
                  text: 'ذكر', size: 18, isBold: false, color: Colors.black),
              Radio(
                value: _Gender.female,
                groupValue: _groupValue,
                onChanged: onChange,
              ),
              ArabicTitle(
                  text: 'انثي', size: 18, isBold: false, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}

enum _Gender {
  male,
  female,
}
