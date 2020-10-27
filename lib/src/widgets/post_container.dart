import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/models/models.dart';

class PostContainer extends StatelessWidget {
  final User currentUser;

  PostContainer({@required this.currentUser});

  _buildTop() => Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(currentUser.imageUrl),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration:
                  InputDecoration.collapsed(hintText: 'what\'s on your mind? '),
            ),
          )
        ],
      );

  Widget _buildRowButtons() => Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(Icons.video_call, 'live', Colors.red),
              VerticalDivider(width: 8, thickness: .5),
              _buildButton(Icons.photo_library, 'photo', Colors.green),
              VerticalDivider(width: 8),
              _buildButton(Icons.video_call, 'room', Colors.purple),
            ],
          ),
        ),
      );

  Widget _buildButton(icon, lable, color) => FlatButton.icon(
        label: Text(lable),
        icon: Icon(
          icon,
          color: color,
        ),
        onPressed: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        children: [
          _buildTop(),
          Divider(height: 10, thickness: .5),
          _buildRowButtons(),
        ],
      ),
    );
  }
}
