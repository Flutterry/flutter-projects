import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file:///C:/Users/ahmed_essam/AndroidStudioProjects/flutter_projects/lib/src/presenters/auth_presenter.dart';

class SignInBloc extends Cubit<bool> {
  AuthPresenter _auth = AuthPresenter();

  SignInBloc() : super(false);

  /// if return null this mean there is no error
  /// else return error message
  Future<String> signIn(String email, String password) =>
      _auth.signIn(email, password);
}
