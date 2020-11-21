import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screens/game_screen/widgets/cell.dart';

class GameBody extends StatefulWidget {
  final double gameWidth, gameHeight;

  GameBody(this.gameWidth, this.gameHeight);

  @override
  _GameBodyState createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  var currentPlayer = true;

  List<List<Tile>> grid =
      List.generate(6, (x) => List.generate(7, (y) => Tile(y, x, -1)));

  List<List<Tile>> get cols => List.generate(7, (x) => List.generate(6, (y) => grid[y][x]));

  Iterable<Tile> get flatGrid => grid.expand((e) => e);

  @override
  Widget build(BuildContext context) {
    var tileWidth = widget.gameWidth / 7;
    var tileHeight = widget.gameHeight / 6;
    var margin = 4;

    List<Widget> children = flatGrid
        .map((e) => Positioned(
              width: tileWidth,
              height: tileHeight,
              left: tileWidth * e.x,
              top: tileHeight * e.y,
              child: GestureDetector(
                onTap: () {
                  if (!canClick(e)) return;
                  changeInCol(e.x);
                },
                child: Cell(
                    tileWidth - 2 * margin, tileHeight - 2 * margin, e.value),
              ),
            ))
        .toList();

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        width: widget.gameWidth,
        height: widget.gameHeight,
        child: Stack(children: children),
      ),
    );
  }

  bool canClick(Tile e){
    return cols[e.x].any((element) => element.value == -1);
  }

  void changeInCol(int index){
    var list = cols[index].reversed;
    var firstNonTile = list.firstWhere((element) => element.value == -1);
    firstNonTile.value = currentPlayer? 1 : 0;
    currentPlayer = !currentPlayer;
    setState(() {});
  }

  bool checkWinner(List<Tile> tiles){
    var yellow = 0;
    var red = 0;

    for(var i  = 0 ; i< tiles.length; i++){
      if(yellow == 4)
        return false;
      if(red == 4)
        return true;

      if(tiles[i].value == 0){
        red++;
        yellow = 0;
      }
      if(tiles[i].value == 1){
        yellow++;
        red = 0;
      }

      if(tiles[i].value == -1){
        red = 0;
        yellow = 0;
      }

    }

    return null;
  }
}

class Tile {
  int x, y, value;

  Tile(this.x, this.y, this.value);
}
