import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/models.dart';

class StorePresenter {
  var _store = FirebaseFirestore.instance;
  static var _storePresenter = StorePresenter._();

  StorePresenter._();

  factory StorePresenter() {
    return _storePresenter;
  }

  Future<String> uploadUser(UserModel user) async {
    try {
      await _store.collection('users').doc(user.id).set(user.toMap());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> loadTen({
    @required List<UserModel> users,
    @required bool isLoading,
    @required String query,
    @required Function(bool) onLoad,
  }) async {
  }
}
