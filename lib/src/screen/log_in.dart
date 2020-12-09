import 'package:flutter/material.dart';
import 'package:flutter_projects/src/bloc/blocs.dart';
import 'package:flutter_projects/src/screen/screens.dart';
import 'package:flutter_projects/src/service/auth_services.dart';
import 'package:flutter_projects/src/widget/widgets.dart';

import '../utils.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var emailController = TextEditingController(),
      passwordController = TextEditingController();

  var passwordNode = FocusNode();

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var loadingBloc = LoadingBloc();
  var authServices = AuthServices.instance();

  void signIn() async {
    if (formKey.currentState.validate() == false) return;

    try {
      loadingBloc.loadingSink(true);
      var email = emailController.text;
      var password = passwordController.text;
      await authServices.signIn(email, password);
      navClear(context, Home());
    } catch (e) {
      loadingBloc.loadingSink(false);
      showSnakbar(scaffoldKey, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [Image.asset(image('lg')), buildLogInForm()],
                ),
              ),
            ),
            StreamBuilder(
              stream: loadingBloc.loadingSteam,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                var result =
                    (!snapshot.hasData || !snapshot.data) ? false : true;
                return Loading(isloading: (result));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogInForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextFormField(
            controller: emailController,
            nextNode: passwordNode,
            lable: 'Email',
            errorMessage: 'please enter a valid email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validation: (value) {
              return valid(emailRegx, value);
            },
          ),
          MyTextFormField(
            controller: passwordController,
            myNode: passwordNode,
            lable: 'Password',
            errorMessage: 'please enter a valid password',
            icon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            validation: (value) {
              return valid(passwordRegx, value);
            },
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: signIn,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomTitle(
                text: 'Log In',
                color: white,
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
              onTap: () {
                nav(context, Regester());
              },
              child: CustomTitle(text: 'Regester from here')),
        ],
      ),
    );
  }
}
