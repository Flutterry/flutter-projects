import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name, email, id;
  List likedFood, likedRestaurant;

  UserModel.fromFirebase(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    var map = snapshot.data();
    this.name = map['name'];
    this.email = map['email'];
    this.likedFood = map['likedFood'] ?? [];
    this.likedRestaurant = map['likedRestaurant'] ?? [];
  }

  UserModel.fromUserCredential(UserCredential credential) {
    var user = credential.user;

    this.id = user.uid;
    this.name = user.displayName == null ? 'unnamed user' : user.displayName;
    this.email = user.email;
    this.likedFood = [];
    this.likedRestaurant = [];
  }

  toMap() => {
        'name': this.name,
        'email': this.email,
        'likedFood': this.likedFood,
        'likedRestaurant': this.likedRestaurant,
      };

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}
