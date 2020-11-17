import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/src/model/models.dart';

class UserBloc {
  var _userIdStreamController = StreamController<String>();

  Function(String) get userIdSink => _userIdStreamController.sink.add;

  Stream<String> get _userIdStream => _userIdStreamController.stream;

  var _userStreamController = StreamController<UserModel>();

  Function(UserModel) get _userSink => _userStreamController.sink.add;

  Stream<UserModel> get userStream => _userStreamController.stream;

  UserBloc() {
    _userIdStream.listen((String userId) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots()
          .listen((DocumentSnapshot documentSnapshot) {
        _userSink(UserModel.fromFirebaseSnapshot(documentSnapshot));
      });
    });
  }

  dispose() {
    _userIdStreamController.close();
    _userStreamController.close();
  }
}
