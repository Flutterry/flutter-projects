import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils.dart';

class Loading extends StatelessWidget {
  final bool isloading;

  const Loading({Key key, this.isloading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(.2),
            child: SpinKitThreeBounce(color: red),
          )
        : SizedBox.shrink();
  }
}
