import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/utils/colors.dart';
import 'package:flutter_projects/src/widget/loading.dart';
import 'package:intl/intl.dart';

import '../blocs/blocs.dart';
import '../model/models.dart';

class ChatViewer extends StatelessWidget {
  final String userId;
  MessageBloc messageBloc;
  final _controller = ScrollController();

  ChatViewer(this.userId) {
    this.messageBloc = MessageBloc(userId);
    this.messageBloc.messageSink(MessageEvent.startToListen);
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent / 2) {
        messageBloc.messageSink(MessageEvent.loadMore);
      }
    });
    return StreamBuilder(
      stream: messageBloc.messageStream,
      builder: (context, AsyncSnapshot<List<MessageModel>> snapshot) {
        if (snapshot.hasData) {
          var messages = snapshot.data;
          return ListView.builder(
            controller: _controller,
            itemCount: messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              var message = messages[index];
              if (index == messages.length - 1)
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15),
                    MessageViewer(message),
                  ],
                );
              return MessageViewer(message);
            },
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class MessageViewer extends StatelessWidget {
  final MessageModel message;

  MessageViewer(this.message);

  @override
  Widget build(BuildContext context) {
    var isText = message.type == MessageType.text.toString();
    var isImage = message.type == MessageType.image.toString();

    return isText
        ? MessageTextViewer(message)
        : isImage
            ? MessageImageViewer(message)
            : SizedBox.shrink();
  }
}

class MessageTextViewer extends StatelessWidget {
  final MessageModel message;
  final auth = FirebaseAuth.instance;
  bool thisMessageFromMe;

  MessageTextViewer(this.message) {
    thisMessageFromMe = auth.currentUser.uid == message.from;
  }

  BorderRadius getBorder(bool messageFromMe, double radius) {
    var border = Radius.circular(radius);
    if (messageFromMe)
      return BorderRadius.only(topLeft: border, bottomLeft: border);
    else
      return BorderRadius.only(topRight: border, bottomRight: border);
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var minWidth = deviceSize.width * .1;
    var maxWidth = deviceSize.width * .8;
    const borderRadius = 10.0;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            thisMessageFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            constraints: BoxConstraints(maxWidth: maxWidth, minWidth: minWidth),
            decoration: BoxDecoration(
                color: thisMessageFromMe
                    ? Palette.darkColor.withOpacity(.2)
                    : Palette.darkColor.withOpacity(.5),
                borderRadius: getBorder(thisMessageFromMe, borderRadius)),
            child: Column(
              crossAxisAlignment: thisMessageFromMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(height: 5),
                DateText(
                    date: message.date,
                    short: true,
                    color: thisMessageFromMe ? Colors.grey : Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageImageViewer extends StatelessWidget {
  final MessageModel message;
  final auth = FirebaseAuth.instance;
  bool thisMessageFromMe;

  MessageImageViewer(this.message) {
    thisMessageFromMe = auth.currentUser.uid == message.from;
  }

  @override
  Widget build(BuildContext context) {
    var images = message.text.split(',');
    var deviceSize = MediaQuery.of(context).size;
    var maxHeight = deviceSize.height * .4;
    var maxWidth = deviceSize.width * .8;
    const borderRadius = 8.0;

    oneImage() => ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Row(
            children: [
              Expanded(child: ImageContainer(image: images[0])),
            ],
          ),
        );

    twoImages() => ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Row(
            children: [
              Expanded(child: ImageContainer(image: images[0])),
              Expanded(child: ImageContainer(image: images[1])),
            ],
          ),
        );

    threeImages() => ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: ImageContainer(image: images[0])),
                    Expanded(child: ImageContainer(image: images[1])),
                  ],
                ),
              ),
              Expanded(child: ImageContainer(image: images[2])),
            ],
          ),
        );

    fourImages() => ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: ImageContainer(image: images[0])),
                    Expanded(child: ImageContainer(image: images[1])),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: ImageContainer(image: images[2])),
                    Expanded(child: ImageContainer(image: images[3])),
                  ],
                ),
              ),
            ],
          ),
        );

    moreThanFourImages() => ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: ImageContainer(image: images[0])),
                    Expanded(child: ImageContainer(image: images[1])),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: ImageContainer(image: images[2])),
                    Expanded(
                        child: Stack(
                      children: [
                        ImageContainer(image: images[3]),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.grey.withOpacity(.5),
                          child: Center(
                              child: Text(
                            '+${images.length - 4}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        );

    var length = images.length;
    return Row(
      mainAxisAlignment:
          thisMessageFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: thisMessageFromMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              width: maxWidth,
              height: maxHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: length == 1
                    ? oneImage()
                    : length == 2
                        ? twoImages()
                        : length == 3
                            ? threeImages()
                            : length == 4
                                ? fourImages()
                                : moreThanFourImages(),
              ),
            ),
            DateText(date: message.date),
          ],
        ),
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key key,
    @required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.darkColor,
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
    );
  }
}

class DateText extends StatelessWidget {
  const DateText({
    Key key,
    @required this.date,
    this.short = false,
    this.color = Colors.grey,
  }) : super(key: key);

  final Timestamp date;
  final bool short;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2, 0, 4),
      child: Text(
        DateFormat(!short ? 'yyyy-MM-dd hh:mm a' : 'hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
        ),
        style: TextStyle(fontSize: 11, color: color),
      ),
    );
  }
}
