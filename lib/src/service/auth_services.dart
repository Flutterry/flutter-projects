import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_projects/src/model/models.dart';

class AuthServices {
  //singleton class
  AuthServices._();
  static var _authServices = AuthServices._();
  factory AuthServices.instance() => _authServices;

//declare variables
  var _auth = FirebaseAuth.instance;
  CollectionReference get userCollection =>
      FirebaseFirestore.instance.collection('users');

  Future<UserCredential> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signUp(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _auth.signOut();

  bool checkUser() => _auth.currentUser != null;

  /// remember to set user id
  Future<void> uploadNewUser(UserModel user) =>
      userCollection.doc(user.id).set(user.toMap());

  ///remember to set user id
  Future<void> updateUserData(UserModel user) =>
      userCollection.doc(user.id).update(user.toMap());

  Future<DocumentSnapshot> getUserById(String userId) =>
      userCollection.doc(userId).get();
}
