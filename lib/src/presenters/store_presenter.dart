import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart' as model;

class StorePresenter {
  var _store = FirebaseFirestore.instance;

  Future<void> updateUserData(User currentUser) async {
    var user = model.User(
      id: currentUser.uid,
      name: currentUser.displayName,
      email: currentUser.email,
      image: currentUser.photoURL,
      onLine: true,
      status: 'hi there, I\'m using phoenix chat app',
    );
    await _store.collection('users').doc(currentUser.uid).set(user.toMap());
  }

  onLineUser(String uid, bool online) {
    _store.collection('users').doc(uid).update({'onLine': online});
  }

  Future<QuerySnapshot> getUsersByName(String name) async {
    print('start searching for $name');
    return _store
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: name)
        .get();
  }
}
