import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widget/widgets.dart';

class ChatRoom extends StatelessWidget {
  final String userId;

  ChatRoom(this.userId);

  closeKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  void updateLastOpen() {
    var auth = FirebaseAuth.instance;
    FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(auth.currentUser.uid)
        .collection('room')
        .doc(userId)
        .update({'last_open': Timestamp.now()});
  }

  @override
  Widget build(BuildContext context) {
    updateLastOpen();
    var border = Radius.circular(40.0);
    return Scaffold(
      backgroundColor: Palette.darkColor,
      body: GestureDetector(
        onTap: () => closeKeyboard(context),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Nav.pop(context))
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: border,
                    topRight: border,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: border,
                        topRight: border,
                      ),
                      color: Colors.white,
                    ),
                    child: ChatViewer(userId),
                  ),
                ),
                flex:8,
              ),
              SendingManager(userId)
            ],
          ),
        ),
      ),
    );
  }
}
