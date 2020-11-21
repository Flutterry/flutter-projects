import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screens/game_screen/widgets/game_body.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Connected Four')),
      body: GameBody(deviceSize.width * .95, deviceSize.height * .5),
    );
  }
}
