import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id, image, name;
  Category({this.id, this.image, this.name});

  Category.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    var map = snapshot.data();

    this.image = map['image'];
    this.name = map['name'];
  }

  toMap() => {
        'image': this.image,
        'name': this.name,
      };

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}
