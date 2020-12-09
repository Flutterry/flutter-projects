import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String id, name, image, foodId;
  int quantity;
  double price;

  CartItem.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    var map = snapshot.data();
    this.name = map['name'];
    this.image = map['image'];
    this.foodId = map['foodId'];
    this.quantity = map['quantity'];
    this.price = map['price'];
  }

  toMap() => {
        'name': this.name,
        'image': this.image,
        'foodId': this.foodId,
        'quantity': this.quantity,
        'price': this.price,
      };

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}
