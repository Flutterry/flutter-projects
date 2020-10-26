import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('master branch'),
      ),
      body: Center(
        child: Text('this is a master branch please checkout to other branch'),
      ),
    );
  }
}
