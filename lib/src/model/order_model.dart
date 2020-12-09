import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id, items, status, userId;
  Timestamp createdAt;
  double amount;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    var map = snapshot.data();
    items = map['items'];
    amount = map['amount'];
    status = map['status'];
    createdAt = map['createdAt'];
    userId = map['userId'];
  }

  toMap() => {
        'items': this.items,
        'amount': this.amount,
        'status': this.status,
        'createdAt': this.createdAt,
        'userId': this.userId,
      };

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}

enum OrderStatus { wating, delivered, cancelled }
