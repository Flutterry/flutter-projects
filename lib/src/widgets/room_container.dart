import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/models/models.dart';
import 'package:flutter_projects/src/utils/palette.dart';

class RoomContainer extends StatelessWidget {
  final List<User> onlineUsers;

  RoomContainer({this.onlineUsers});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: onlineUsers.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: OutlineButton(
                onPressed: () {},
                borderSide: BorderSide(color: Colors.blue[100], width: 3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (r) =>
                          Palette.createRoomGradient.createShader(r),
                      child: Icon(
                        Icons.video_call,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Create\nRoom'),
                  ],
                ),
              ),
            );
          } else
            return _Avatar(
              image: onlineUsers[index - 1].imageUrl,
              isActive: true,
            );
        },
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String image;
  final bool isActive;

  _Avatar({this.image, this.isActive});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: CachedNetworkImageProvider(image),
          radius: 35,
        ),
        isActive
            ? Positioned(
                right: 10,
                bottom: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Palette.online,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                ))
            : SizedBox.shrink()
      ],
    );
  }
}
