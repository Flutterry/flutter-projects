import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_projects/src/models/models.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Content> contents;
  final bool isOriginal;

  ContentList({
    key,
    @required this.title,
    @required this.contents,
    this.isOriginal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
        ),
        Container(
          height: isOriginal ? 400 : 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contents.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
                height: isOriginal ? 390 : 190,
                width: isOriginal ? 200 : 100,
                child: Image.asset(
                  contents[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
