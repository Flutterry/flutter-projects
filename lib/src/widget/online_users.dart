import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/models.dart';
import '../utils/utils.dart';
import 'widgets.dart';

class OnlineUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var border = const Radius.circular(40.0);
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: border,
        topRight: border,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: MediaQuery.of(context).size.height * 0.2,
        child: FutureBuilder<List<String>>(
            future: getUserIds(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userIds = snapshot.data;
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userIds.length,
                    itemBuilder: (context, index) => _UserCard(userIds[index]));
              } else
                return Loading();
            }),
      ),
    );
  }

  Future<List<String>> getUserIds() async {
    var store = FirebaseFirestore.instance;
    var myId = FirebaseAuth.instance.currentUser.uid;
    var querySnapShot = await store
        .collection('chat_rooms')
        .doc(myId)
        .collection('room')
        .orderBy('date', descending: true)
        .get();
    var ids = <String>[];
    querySnapShot.docs.map((e) => e.id).forEach((docId) => ids.add(docId));
    return ids;
  }
}

class _UserCard extends StatelessWidget {
  _UserCard(String userId) {
    _userSink(userId);
  }

  final _userStreamController = StreamController<String>();

  Function(String) get _userSink => _userStreamController.sink.add;

  Stream<UserModel> get _userStream =>
      _userStreamController.stream.transform(_streamTransformer);

  final _streamTransformer = StreamTransformer<String, UserModel>.fromHandlers(
      handleData: (userId, sink) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      var user = UserModel.fromFirebaseSnapshot(snapshot);
      sink.add(user);
    });
  });

  void dispose() {
    _userStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    var radius = MediaQuery.of(context).size.width * .07;
    return StreamBuilder(
      stream: _userStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: radius + 5,
                      backgroundColor: user.onLine ? Colors.green : Colors.red,
                    ),
                    CircleAvatar(
                      radius: radius + 3,
                      backgroundColor: Palette.scaffoldColor,
                    ),
                    CircleAvatar(
                      radius: radius,
                      backgroundColor: user.onLine ? Colors.green : Colors.red,
                      backgroundImage: NetworkImage(user.image),
                    ),
                  ],
                ),
              ),
              Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: radius / 2,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Theme(
                data: ThemeData(accentColor: Palette.darkColor),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
