import 'package:firebase_auth/firebase_auth.dart';

import 'storage_presenter.dart';
import 'store_presenter.dart';

class AuthPresenter {
  var _auth = FirebaseAuth.instance;
  var _storage = StoragePresenter();
  var _store = StorePresenter();

  ///return true if there is a signed user
  bool checkUser() {
    try {
      return _auth.currentUser != null;
    } catch (error) {
      return false;
    }
  }

  ///return error message
  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  /// return error message
  Future<String> signUp(
    String email,
    String password,
    String userName,
    String imagePath,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _storage.uploadProfileImage(imagePath, (String downloadUrl) async {
        await _auth.currentUser
            .updateProfile(displayName: userName, photoURL: downloadUrl);
        await _store.updateUserData(_auth.currentUser);
      });
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> sendRestPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
