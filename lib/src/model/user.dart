import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String id, name, email, status , image;
  bool onLine;

  UserModel({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.status,
    @required this.onLine,
    @required this.image,
  });

  UserModel.fromFirebaseSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.data()['name'];
    email = snapshot.data()['email'];
    status = snapshot.data()['status'];
    onLine = snapshot.data()['onLine'];
    image = snapshot.data()['image'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'status': status,
        'onLine': onLine,
        'image': image,
      };
}
