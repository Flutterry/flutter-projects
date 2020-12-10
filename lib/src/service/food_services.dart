import 'package:cloud_firestore/cloud_firestore.dart';

class FoodServices {
  static var _instance = FoodServices._();
  FoodServices._();
  factory FoodServices.instance() => _instance;

  CollectionReference get _foodCollection =>
      FirebaseFirestore.instance.collection('food');

  Future<QuerySnapshot> getFood() =>
      _foodCollection.limit(10).orderBy('rate', descending: true).get();

  Future<QuerySnapshot> getFoodByRestaurant(String id) =>
      _foodCollection.where('restaurantId', isEqualTo: id).limit(10).get();
}
