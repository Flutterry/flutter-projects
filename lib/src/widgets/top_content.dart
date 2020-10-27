import 'package:flutter/material.dart';
import 'package:flutter_projects/src/assets.dart';

class TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.sintel), fit: BoxFit.cover)),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 140,
          right: 0,
          left: 0,
          child: Image.asset(
            Assets.sintelTitle,
            scale: 4,
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(Icons.add, 'List'),
              FlatButton.icon(
                padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                color: Colors.white,
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
                label: Text('Play', style: TextStyle(color: Colors.grey[900])),
                onPressed: () {},
              ),
              _buildButton(Icons.info_outline, 'Info'),
            ],
          ),
        )
      ],
    );
  }

  _buildButton(icon, text) => Column(
        children: [
          Icon(icon),
          SizedBox(height: 5),
          Text(text),
        ],
      );
}
