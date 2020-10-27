import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/data.dart';
import 'package:flutter_projects/src/utils/palette.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SliverAppBar _buildAppbar() => SliverAppBar(
        backgroundColor: Colors.white,
        floating: true,
        centerTitle: false,
        actions: [
          CircleButton(icon: Icons.search),
          CircleButton(icon: MdiIcons.facebookMessenger),
        ],
        title: Text(
          'facebook',
          style: TextStyle(
            color: Palette.facebookBlue,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: -1.2,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppbar(),
          SliverToBoxAdapter(child: PostContainer(currentUser: currentUser)),
          SliverToBoxAdapter(child: RoomContainer(onlineUsers: onlineUsers)),
          SliverToBoxAdapter(
              child: Stories(currentUser: currentUser, stories: stories)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return PostCard(post: posts[index]);
            },
            childCount: posts.length,
          ))
        ],
      ),
    );
  }
}
