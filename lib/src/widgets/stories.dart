import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/models/models.dart';
import 'package:flutter_projects/src/utils/palette.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;

  Stories({this.currentUser, this.stories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
        itemCount: stories.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0)
            return _storyCard(isMe: true, user: currentUser);
          else
            return _storyCard(story: stories[index - 1]);
        },
      ),
    );
  }

  Widget _storyCard({User user, bool isMe = false, Story story}) => Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 3, 5),
            width: 110,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: isMe ? user.imageUrl : story.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 3, 5),
            width: 110,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: Palette.storyGradient,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: isMe
                ? Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Palette.facebookBlue,
                    ),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundColor: Palette.facebookBlue,
                    child: CircleAvatar(
                      radius: story.isViewed ? 20 : 17,
                      backgroundImage:
                          CachedNetworkImageProvider(story.imageUrl),
                    ),
                  ),
          ),
          Positioned(
            bottom: 12,
            left: 10,
            right: 8,
            child: Text(
              isMe ? 'Add To Story' : story.user.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
}
