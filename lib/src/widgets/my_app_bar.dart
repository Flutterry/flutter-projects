import 'package:flutter/material.dart';
import 'package:flutter_projects/src/assets.dart';

class MyAppBar extends StatelessWidget {
  final double _scrollOffset;

  MyAppBar(this._scrollOffset);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black
          .withOpacity((_scrollOffset / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            children: [
              Image.asset(Assets.netflixLogo0),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBarButton('TV Shows', () {}),
                    _buildBarButton('Movies', () {}),
                    _buildBarButton('My List', () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarButton(text, func) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}
