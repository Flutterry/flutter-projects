import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email, image, id, name, status;
  bool onLine;

  User({
    this.email,
    this.image,
    this.id,
    this.status,
    this.name,
    this.onLine,
  });

  User.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    id = snapshot.id;
    email = data['email'];
    image = data['image'];
    name = data['name'];
    onLine = data['onLine'];
    status = data['status'];
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'image': image,
        'name': name,
        'onLine': onLine,
        'status': status,
      };
}
