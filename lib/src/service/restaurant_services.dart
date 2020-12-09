import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantServices {
  //singeton class
  static var _instance = RestaurantServices._();
  RestaurantServices._();
  factory RestaurantServices.instance() => _instance;

  CollectionReference get _restaurantCollection =>
      FirebaseFirestore.instance.collection('restaurant');

  Future<QuerySnapshot> getBestRestaurant() =>
      _restaurantCollection.orderBy('rate', descending: true).limit(10).get();

  Future<DocumentSnapshot> getRestaurantById(String id) =>
      _restaurantCollection.doc(id).get();
}
