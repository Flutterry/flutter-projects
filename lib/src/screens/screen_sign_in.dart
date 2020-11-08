import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/src/cubit/is_loading.dart';
import 'package:flutter_projects/src/presenters/auth_presenter.dart';
import 'package:flutter_projects/src/public_helper/helper.dart';
import 'package:flutter_projects/src/screens/screens.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class SignIn extends StatelessWidget {
  var formState = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void signInWithEmailAndPassword(
    BuildContext context,
    IsLoading loadingState,
  ) async {
    var auth = AuthPresenter();
    if (formState.currentState.validate()) {
      loadingState.loading(true);
      var error =
          await auth.signIn(emailController.text, passwordController.text);
      loadingState.loading(false);
      if (error == null)
        pushClear(context, ChatRoom());
      else {
        EdgeAlert.show(
          context,
          icon: Icons.notifications,
          description: error,
          title: 'please try again',
          gravity: EdgeAlert.TOP,
          backgroundColor: darkColor,
          duration: EdgeAlert.LENGTH_LONG,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: BlocBuilder<IsLoading, bool>(
            builder: (context, state) {
              return state
                  ? Loading()
                  : _Screen(
                      signIn: () => signInWithEmailAndPassword(
                          context, BlocProvider.of<IsLoading>(context)),
                      emailController: emailController,
                      passwordController: passwordController,
                      formState: formState,
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  final Function() signIn;
  final GlobalKey<FormState> formState;
  final TextEditingController emailController, passwordController;

  _Screen(
      {this.signIn,
      this.emailController,
      this.passwordController,
      this.formState});

  var passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollableColumn(
            children: [
              SizedBox(height: 20),
              TextShadow(title: 'Phoenix Chat', fontSize: 25),
              TextShadow(title: 'Log In', fontSize: 40),
              Form(
                key: formState,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
                  child: Container(
                    child: Column(
                      children: [
                        TextForm(
                          label: 'Email',
                          icon: Icons.email,
                          keyBoardType: TextInputType.emailAddress,
                          controller: emailController,
                          validate: emailValidation,
                          nextFocus: passwordNode,
                        ),
                        TextForm(
                          focus: passwordNode,
                          label: 'Password',
                          icon: Icons.lock,
                          keyBoardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validate: passwordValidation,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => push(context, ResetPassword()),
                            child: TextShadow(
                                title: 'Forgot Password?', fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 20),
                        RoundedButton(
                          onPress: signIn,
                          title: 'Sign In',
                          titleColor: Colors.white,
                          backgroundColor: darkColor,
                        ),
                        RoundedButton(
                          onPress: () {},
                          title: 'Sign In With Google ',
                          titleColor: darkColor,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ClickableRow(
          title1: 'Don\'t have an Account ?',
          title2: 'Sign up for Free',
          onPress: () => pushReplacement(context, SignUp()),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
