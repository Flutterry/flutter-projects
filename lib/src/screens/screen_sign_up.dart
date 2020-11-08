import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/src/cubit/is_loading.dart';
import 'package:flutter_projects/src/presenters/auth_presenter.dart';
import 'package:flutter_projects/src/public_helper/helper.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

import 'screens.dart';

class ProfileImage {
  String img;

  ProfileImage(this.img);
}

class SignUp extends StatelessWidget {
  final formState = GlobalKey<FormState>();
  final emailController = TextEditingController(),
      passwordController = TextEditingController(),
      userNameController = TextEditingController();
  final userImage = ProfileImage(null);
  final auth = AuthPresenter();

  void signUpWithEmailAndPassword(context, IsLoading isLoading) async {
    if (formState.currentState.validate()) {
      if (userImage.img == null) {
        showMsg(context, 'Please select profile image',
            'click on camera icon to select an image');
      } else {
        isLoading.loading(true);
        var error = await auth.signUp(emailController.text,
            passwordController.text, userNameController.text, userImage.img);
        isLoading.loading(false);
        if (error == null) {
          pushClear(context, ChatRoom());
        } else {
          showMsg(context, 'Please try again later', error.toString());
        }
      }
    }
  }

  void showMsg(BuildContext context, String title, String msg) {
    EdgeAlert.show(
      context,
      icon: Icons.notifications,
      description: msg,
      title: title,
      gravity: EdgeAlert.TOP,
      backgroundColor: darkColor,
      duration: EdgeAlert.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: BlocBuilder<IsLoading, bool>(
            builder: (context, state) => state
                ? Loading()
                : _Screen(
                    formState: formState,
                    emailController: emailController,
                    passwordController: passwordController,
                    userNameController: userNameController,
                    signUp: () => signUpWithEmailAndPassword(
                        context, BlocProvider.of<IsLoading>(context)),
                    img: userImage,
                  ),
          ),
        ),
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final TextEditingController emailController,
      passwordController,
      userNameController;
  final passwordNode = FocusNode(),
      rePasswordNode = FocusNode(),
      emailNode = FocusNode();
  final Function() signUp;
  final ProfileImage img;

  _Screen({
    @required this.formState,
    @required this.emailController,
    @required this.passwordController,
    @required this.userNameController,
    @required this.signUp,
    @required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollableColumn(
            children: [
              SizedBox(height: 20),
              TextShadow(title: 'Phoenix chat', fontSize: 25),
              TextShadow(title: 'Sign Up', fontSize: 40),
              Form(
                key: formState,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Column(
                    children: [
                      GetProfileImage((String image) {
                        img.img = image;
                      }),
                      SizedBox(height: 16),
                      TextForm(
                        label: 'User Name',
                        icon: Icons.account_circle_rounded,
                        keyBoardType: TextInputType.name,
                        controller: userNameController,
                        validate: (value) {
                          var valid = validation('[a-zA-Z0-9_ ]{2,}', value);
                          return !valid ? 'please enter valid user name' : null;
                        },
                        nextFocus: emailNode,
                      ),
                      TextForm(
                        focus: emailNode,
                        label: 'Email',
                        icon: Icons.email,
                        keyBoardType: TextInputType.emailAddress,
                        controller: emailController,
                        validate: emailValidation,
                        nextFocus: passwordNode,
                      ),
                      TextForm(
                          focus: passwordNode,
                          nextFocus: rePasswordNode,
                          label: 'Password',
                          icon: Icons.lock,
                          keyBoardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validate: passwordValidation),
                      TextForm(
                        focus: rePasswordNode,
                        label: 'Re-Enter Password',
                        icon: Icons.lock,
                        keyBoardType: TextInputType.visiblePassword,
                        validate: (value) {
                          var valid =
                              validation(passwordController.text, value);
                          return !valid ? 'password not same' : null;
                        },
                      ),
                      SizedBox(height: 50),
                      RoundedButton(
                        onPress: signUp,
                        title: 'Sign Up',
                        titleColor: Colors.white,
                        backgroundColor: darkColor,
                      ),
                      RoundedButton(
                        onPress: () {},
                        title: 'Sign Up With Google ',
                        titleColor: darkColor,
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ClickableRow(
          title1: 'already have an account ?',
          title2: 'Sign In',
          onPress: () => pushReplacement(context, SignIn()),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
