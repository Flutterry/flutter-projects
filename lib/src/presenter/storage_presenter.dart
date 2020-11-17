import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StoragePresenter {
  var _storage = FirebaseStorage.instance;
  static var _storagePresenter = StoragePresenter._();

  StoragePresenter._();

  factory StoragePresenter() {
    return _storagePresenter;
  }

  Future<String> upLoadProfileImage(String userId, String imagePath) async {
    var file = File(imagePath);
    var ref = _storage.ref().child('profileImages').child('$userId.png');

    try {
      var task = await ref.putFile(file);
      if (task.state == TaskState.error) {
        return 'error';
      }
      var downloadLink = await task.ref.getDownloadURL();
      return downloadLink;
    } catch (e) {
      ref.delete();
      return 'error';
    }
  }
}