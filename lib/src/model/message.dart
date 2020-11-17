import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageModel {
  String id, text, from,type;
  Timestamp date;

  MessageModel(
      {@required this.text,
      @required this.from,
      @required this.type,
      Timestamp date}) {
    this.date = date ?? Timestamp.now();
  }

  MessageModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    text = snapshot.data()['text'];
    from = snapshot.data()['from'];
    type = snapshot.data()['type'];
    date = snapshot.data()['date'];
  }

  Map<String, dynamic> toMap() => {
        'text': text,
        'from': from,
        'type': type,
        'date': date,
      };
}

enum MessageType {
  text,
  image,
}
