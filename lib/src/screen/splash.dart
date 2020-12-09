import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screen/screens.dart';
import 'package:flutter_projects/src/service/services.dart';

import '../utils.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var result = AuthServices.instance().checkUser();
      if (result)
        nav(context, Home());
      else
        nav(context, LogIn());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            image('lg'),
          ),
        ),
      ),
    );
  }
}
