import 'package:firebase_auth/firebase_auth.dart';

class AuthPresenter {
  var _auth = FirebaseAuth.instance;
  static final AuthPresenter _authPresenter = AuthPresenter._init();

  AuthPresenter._init();

  factory AuthPresenter() => _authPresenter;

  User get currentUser => _auth.currentUser;

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  bool checkUser() {
    try {
      return _auth.currentUser != null;
    } catch (e) {
      return null;
    }
  }

  ///return error state
  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteCurrentUser() async {
    try {
      await _auth.currentUser.delete();
      return;
    } catch (e) {
      return;
    }
  }

  ///return error state
  Future<String> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateProfile(String userName, String imageDownloadLink) async{
    try{
        await _auth.currentUser.updateProfile(displayName: userName, photoURL: imageDownloadLink);
        return null;
    }catch(e){
        return e.toString();
    }
  }
}
