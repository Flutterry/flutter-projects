import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/models/models.dart';
import 'package:flutter_projects/src/utils/palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTop(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 5),
            child: Text(post.caption),
          ),
          post.imageUrl == null
              ? SizedBox.shrink()
              : Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: CachedNetworkImage(imageUrl: post.imageUrl)),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(3),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Palette.facebookBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.thumb_up,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              Expanded(
                  child: Text(post.likes.toString(),
                      style: TextStyle(color: Colors.grey))),
              Text(post.comments.toString(),
                  style: TextStyle(color: Colors.grey)),
              SizedBox(width: 4),
              Text('comments', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 8),
              Text(post.shares.toString(),
                  style: TextStyle(color: Colors.grey)),
              SizedBox(width: 4),
              Text('shares', style: TextStyle(color: Colors.grey)),
            ],
          ),
          _buildButtons()
        ],
      ),
    );
  }

  _buildButton(icon, text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.grey[600],
              ),
              SizedBox(
                width: 5,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  _buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(MdiIcons.thumbUpOutline, 'Like'),
          _buildButton(MdiIcons.commentOutline, 'Comment'),
          _buildButton(MdiIcons.shareOutline, 'Share'),
        ],
      );

  _buildTop() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(post.user.imageUrl),
      ),
      title: Text(post.user.name),
      subtitle: Row(
        children: [
          Text('${post.timeAgo}.'),
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.public,
            size: 12,
            color: Colors.grey,
          ),
        ],
      ),
      trailing: Icon(Icons.more_horiz),
    );
  }
}
