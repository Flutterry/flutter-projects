import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/models/tile.dart';

import '../utils/utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<List<Tile>> grid = List.generate(
      4, (y) => List.generate(4, (x) => Tile(x.toDouble(), y.toDouble(), 0)));

  Iterable<Tile> get flatGrid => grid.expand((element) => element);

  List<List<Tile>> get cols =>
      List.generate(4, (y) => List.generate(4, (x) => grid[x][y]));

  AnimationController parent;

  @override
  void initState() {
    parent =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    parent.addListener(() {
      if(parent.status == AnimationStatus.completed)
        flatGrid.forEach((element) {element.resetAnimation();});
    });
    grid[1][2].value = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var dimension = deviceSize.width * .9;
    var marginBetweenTile = 2;
    var tileSize = dimension / 4;

    List<Widget> stackItems = [];

    //build blank board
    stackItems.addAll(
      flatGrid.map(
        (e) => Positioned(
          left: e.animationX.value * tileSize,
          top: e.animationY.value * tileSize,
          width: tileSize,
          height: tileSize,
          child: Center(
            child: Container(
              width: tileSize - marginBetweenTile * 2,
              height: tileSize - marginBetweenTile * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                color: lightBrown,
              ),
            ),
          ),
        ),
      ),
    );

    //build real blocks
    stackItems.addAll(
      flatGrid.map(
        (e) => AnimatedBuilder(
          animation: parent,
          builder: (context, child) => e.value == 0
              ? SizedBox.shrink()
              : Positioned(
                  left: e.x * tileSize,
                  top: e.y * tileSize,
                  width: tileSize ,
                  height: tileSize,
                  child: Center(
                    child: Container(
                      width: tileSize - marginBetweenTile * 2,
                      height: tileSize - marginBetweenTile * 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cornerRadius),
                        color: numTileColor[e.value],
                      ),
                      child: Center(
                        child: Text(
                          e.value.toString(),
                          style: TextStyle(
                            fontSize: (tileSize / 3) * e.fontSize.value,
                            fontWeight: FontWeight.w700,
                            color: numTextColor[e.value],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: tan,
      body: Center(
        child: Container(
          width: dimension,
          height: dimension,
          decoration: BoxDecoration(
              color: darkBrown,
              borderRadius: BorderRadius.circular(cornerRadius)),
          child: GestureDetector(
            onVerticalDragEnd: (detail) {
              if (detail.velocity.pixelsPerSecond.dy < -5 && canSwipeUp()) {
                doSwipe(swipeUp);
              } else if (detail.velocity.pixelsPerSecond.dy > 5 &&
                  canSwipeDown()) {
                doSwipe(swipeDown);
              }
            },
            onHorizontalDragEnd: (detail) {
              if (detail.velocity.pixelsPerSecond.dx < -5 && canSwipeLeft()) {
                doSwipe(swipeLeft);
              } else if (detail.velocity.pixelsPerSecond.dx > 5 &&
                  canSwipeRight()) {
                doSwipe(swipeRight);
              }
            },
            child: Stack(
              children: stackItems,
            ),
          ),
        ),
      ),
    );
  }

  void doSwipe(void Function() howSwipe) {
    setState(() {
      howSwipe?.call();
      addMoreTile();
      parent.forward(from: 0);
    });
  }

  void swipeLeft() => grid.forEach(merge);

  void swipeRight() => grid.map((e) => e.reversed.toList()).forEach(merge);

  void swipeUp() => cols.forEach(merge);

  void swipeDown() => cols.map((e) => e.reversed.toList()).forEach(merge);

  void addMoreTile() {
    var emptyTiles = flatGrid.where((element) => element.value == 0).toList();
    emptyTiles.shuffle();
    emptyTiles.first.value = 2;
  }

  void merge(List<Tile> tiles) {
    for (var i = 0; i < tiles.length; i++) {
      var nonZeroTiles = tiles.skip(i).skipWhile((t) => t.value == 0);
      if (nonZeroTiles.isEmpty) break;
      var first = nonZeroTiles.first;
      var second = nonZeroTiles
          .skip(1)
          .firstWhere((t) => t.value != 0, orElse: () => null);

      if (second != null && second.value != first.value) second = null;

      if (first != tiles[i] || second != null) {
        var result = first.value;
        first.startMovingTo(parent, tiles[i].x, tiles[i].y);
        first.value = 0;
        if (second != null) {
          result += second.value;
          tiles[i].startChangeFontSize(parent);
          second.value = 0;
        }

        tiles[i].value = result;
      }
    }
  }

  bool canSwipeLeft() {
    var result = grid.any(canSwipe);
    print('get to left : $result');
    return result;
  }

  bool canSwipeRight() {
    var result = grid.map((e) => e.reversed.toList()).any(canSwipe);
    print('get to right : $result');
    return result;
  }

  bool canSwipeUp() {
    var result = cols.any(canSwipe);
    print('get to up : $result');
    return result;
  }

  bool canSwipeDown() {
    var result = cols.map((e) => e.reversed.toList()).any(canSwipe);
    print('get to down : $result');
    return result;
  }

  bool canSwipe(List<Tile> tiles) {
    for (var i = 0; i < tiles.length; i++) {
      if (tiles[i].value == 0) {
        if (tiles.skip(i + 1).any((element) => element.value != 0)) return true;
      } else {
        var nextNonZeroTile = tiles
            .skip(i + 1)
            .firstWhere((element) => element.value != 0, orElse: () => null);

        if (nextNonZeroTile != null && tiles[i].value == nextNonZeroTile.value)
          return true;
      }
    }
    return false;
  }
}
