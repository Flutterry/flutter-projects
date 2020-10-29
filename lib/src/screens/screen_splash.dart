import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/assets.dart';
import 'package:flutter_projects/src/data/public_function.dart';
import 'package:flutter_projects/src/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      pushReplacement(context, GetStartedScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            Assets.applicationLogo,
            scale: 2,
          ),
        ),
      ),
    );
  }
}
