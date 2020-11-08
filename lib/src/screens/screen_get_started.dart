import 'package:flutter/material.dart';

import '../presenters/auth_presenter.dart';
import '../public_helper/helper.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  var visible = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      bool result = AuthPresenter().checkUser();
      if (result)
        pushReplacement(context, ChatRoom());
      else
        setState(() {
          visible = true;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var bigCircleRad = deviceSize.width * 1.5;
    var smallCircleRad = deviceSize.width / 3;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: deviceSize.width,
            height: deviceSize.height,
          ),
          Positioned(
            top: deviceSize.height * .6,
            left: deviceSize.width * .1,
            child: _buildCircle(Color(0xff6941B2), bigCircleRad),
          ),
          Positioned(
            top: deviceSize.height * .55,
            right: deviceSize.width * -.1,
            child:
                _buildCircle(backgroundColor.withOpacity(.2), smallCircleRad),
          ),
          Positioned(
            top: deviceSize.height * -.1,
            left: deviceSize.width * -.2,
            child: _buildCircle(Color(0xff6941B2), deviceSize.width / 2),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: _buildCircleButton(context),
          ),
          TextShadow(title: 'Phoenix Chat', fontSize: 40),
        ],
      )),
    );
  }

  Widget _buildCircleButton(context) => Visibility(
        visible: visible,
        child: FloatingActionButton(
          mini: true,
          onPressed: () => push(context, SignIn()),
          backgroundColor: backgroundColor,
          child: Icon(
            Icons.navigate_next,
            size: 35,
            color: Colors.blueGrey[900],
          ),
        ),
      );

  Widget _buildCircle(color, radius) => Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
}
