import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryServices {
  //singelton class
  static var _instance = CategoryServices._();
  CategoryServices._();
  factory CategoryServices.instance() => _instance;

  CollectionReference get categoryCollection =>
      FirebaseFirestore.instance.collection('category');

  Future<QuerySnapshot> getCategories() => categoryCollection.get();
}
