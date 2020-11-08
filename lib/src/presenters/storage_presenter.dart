import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoragePresenter {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadProfileImage(
      String imageUrl, Function(String) whenDone) async {
    var profileRef = _storage
        .ref()
        .child('profileImages')
        .child('${_auth.currentUser.uid}.png');
    var task = await profileRef.putFile(File(imageUrl)).onComplete;
    if (task.error == null) {
      String downloadUrl = await task.ref.getDownloadURL();
      whenDone(downloadUrl);
    }
  }
}
