import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/data.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  Home({key}) : super(key: key);
}

class _HomeState extends State<Home> {
  var _scrollOffset = 0.0;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.grey[900],
        child: Icon(
          Icons.cast,
          size: 20,
          color: Colors.grey[500],
        ),
        onPressed: () {},
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppBar(_scrollOffset),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(child: TopContent()),
          SliverToBoxAdapter(
              child: Previews(
            key: PageStorageKey('preview'),
          )),
          SliverToBoxAdapter(
              child: ContentList(
                  key: PageStorageKey('my list'),
                  title: 'My List',
                  contents: myList)),
          SliverToBoxAdapter(
              child: ContentList(
            key: PageStorageKey('origin'),
            title: 'Original',
            contents: originals,
            isOriginal: true,
          )),
          SliverToBoxAdapter(
              key: PageStorageKey('trending'),
              child: ContentList(title: 'Trending', contents: trending)),
        ],
      ),
    );
  }
}
