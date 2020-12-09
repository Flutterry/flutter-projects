import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String id, name, image;
  double avgPrice, rate;
  int rates;

  Restaurant.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    var map = snapshot.data();
    this.name = map['name'];
    this.avgPrice = map['avgPrice'];
    this.rate = map['rate'];
    this.image = map['image'];
    this.rates = map['rates'];
  }

  toMap() => {
        'name': this.name,
        'avgPrice': this.avgPrice,
        'rate': this.rate,
        'image': this.image,
        'rates': this.rates,
      };

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}
