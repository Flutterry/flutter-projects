import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/src/presenters/auth_presenter.dart';

class SignUpBloc extends Cubit<bool> {
  AuthPresenter _auth;

  SignUpBloc() : super(false);

  Future<String> signUp(
    String email,
    String password,
    String userName,
    String imagePath,
  ) =>
      _auth.signUp(email, password, userName, imagePath);
}
