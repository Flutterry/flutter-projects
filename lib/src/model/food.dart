import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id, name, image, restaurentId, category;
  bool fav;
  double price, rate;
  int peopleRating;

  Food({
    this.id,
    this.name,
    this.category,
    this.fav,
    this.image,
    this.peopleRating,
    this.price,
    this.rate,
    this.restaurentId,
  });

  Food.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    var map = snapshot.data();

    this.name = map['name'];
    this.image = map['image'];
    this.restaurentId = map['restaurantId'];
    this.category = map['category'];
    this.fav = map['fav'];
    this.price = map['price'];
    this.rate = map['rate'];
    this.peopleRating = map['peopleRating'];
  }

  toMap() => {
        'name': this.name,
        'image': this.image,
        'restaurantId': this.restaurentId,
        'category': this.category,
        'fav': this.fav,
        'price': this.price,
        'rate': this.rate,
        'peopleRating': this.peopleRating,
      };
}
