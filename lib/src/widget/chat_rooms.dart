import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/screen/screens.dart';

import '../model/models.dart';
import '../utils/utils.dart';
import 'widgets.dart';

class ChatRooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getChatIds(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _ChatCard(snapshot.data[index]);
                },
                childCount: snapshot.data.length,
              ),
            );
          } else
            return SliverToBoxAdapter(child: Loading());
        });
  }

  Future<List<String>> getChatIds() async {
    var store = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    var snapshot = await store
        .collection('chat_rooms')
        .doc(auth.currentUser.uid)
        .collection('room')
        .orderBy('date', descending: true)
        .get();

    var ids = <String>[];
    snapshot.docs.forEach((element) {
      ids.add(element.id);
    });

    return ids;
  }
}

class _ChatCard extends StatelessWidget {
  _ChatCard(String chatId) {
    chatSink(chatId);
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var radius = deviceSize.width * 0.07;
    return StreamBuilder<Map<String, dynamic>>(
      stream: chatStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          UserModel user = data['user'];
          MessageModel message = data['message'];
          Timestamp lastOpen = data['last'];
          var isReade = FirebaseAuth.instance.currentUser.uid == message.from || lastOpen != null &&
              message.date.toDate().isBefore(lastOpen.toDate());
          return Container(
            color: isReade ? Colors.white : Palette.darkColor.withOpacity(.05),
            child: ListTile(
              onTap: () => Nav.push(context, ChatRoom(user.id)),
              leading: CircleAvatar(
                radius: radius,
                backgroundImage: NetworkImage(user.image),
              ),
              title: Text(user.name),
              subtitle: Text(message.type == MessageType.text.toString()
                  ? message.text
                  : 'Image'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DateText(date: message.date, short: true),
                  isReade
                      ? SizedBox.shrink()
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Palette.darkColor,
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                                color: Colors.white, fontSize: radius / 2),
                          ),
                        ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  final _chatStreamController = StreamController<String>();

  Function(String) get chatSink => _chatStreamController.sink.add;

  Stream<Map<String, dynamic>> get chatStream =>
      _chatStreamController.stream.transform(streamTransformer);
  final streamTransformer =
      StreamTransformer<String, Map<String, dynamic>>.fromHandlers(
          handleData: (String chatId, sink) {
    var auth = FirebaseAuth.instance;
    var store = FirebaseFirestore.instance;
    store
        .collection('chat_rooms')
        .doc(auth.currentUser.uid)
        .collection('room')
        .doc(chatId)
        .snapshots()
        .listen((document) async {
      var message = MessageModel.fromFirebaseDocument(document);
      var user = UserModel.fromFirebaseSnapshot(
          await store.collection('users').doc(document.id).get());
      var lastOpen = document.data()['last_open'];
      var map = {
        'user': user,
        'message': message,
        'last': lastOpen,
      };
      sink.add(map);
    });
  });

  void dispose() {
    _chatStreamController.close();
  }
}
