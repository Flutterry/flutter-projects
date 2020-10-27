import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/data.dart';
import 'package:flutter_projects/src/models/models.dart';

class Previews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Previews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _buildReview(previews[index]),
            itemCount: previews.length,
          ),
        )
      ],
    );
  }

  Widget _buildReview(Content preview) => Container(
        margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(preview.imageUrl)),
                border: Border.all(color: preview.color, width: 3),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(preview.titleImageUrl),
            )
          ],
        ),
      );

  Previews({key}) : super(key: key);
}
