import 'package:flutter/material.dart';

import '../model/models.dart';
import 'screens.dart';
import '../service/auth_services.dart';
import '../utils.dart';
import '../widget/widgets.dart';
import '../bloc/blocs.dart';

class Regester extends StatefulWidget {
  @override
  _RegesterState createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  var emailController = TextEditingController(),
      passwordController = TextEditingController();

  var passwordNode = FocusNode(), rePasswordNode = FocusNode();

  var loadingBloc = LoadingBloc();
  var authServices = AuthServices.instance();

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void regester() async {
    if (formKey.currentState.validate() == false) return;
    loadingBloc.loadingSink(true);
    var email = emailController.text;
    var password = passwordController.text;
    try {
      var signUpResult = await authServices.signUp(email, password);
      var user = UserModel.fromUserCredential(signUpResult);
      await authServices.uploadNewUser(user);
      navClear(context, Home());
    } catch (e) {
      showSnakbar(scaffoldKey, e.toString());
      loadingBloc.loadingSink(false);
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
                  children: [
                    Image.asset(image('lg')),
                    buildRegesterForm(),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream: loadingBloc.loadingSteam,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                var result =
                    (!snapshot.hasData || !snapshot.data) ? false : true;
                return Loading(isloading: result);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegesterForm() {
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
              return valid('^[1-9a-zA-Z_]{3,}@[a-zA-Z]{2,}\\.com\$', value);
            },
          ),
          MyTextFormField(
            controller: passwordController,
            myNode: passwordNode,
            nextNode: rePasswordNode,
            lable: 'Password',
            errorMessage: 'please enter a valid password',
            icon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            validation: (value) {
              return valid('[a-zA-Z1-9_]{8,}', value);
            },
          ),
          MyTextFormField(
            controller: null,
            myNode: rePasswordNode,
            lable: 'Re-Password',
            errorMessage: 'password not same',
            icon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            validation: (value) {
              return valid('^${passwordController.text}\$', value);
            },
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: regester,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomTitle(
                text: 'Sign Up',
                color: white,
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
              onTap: () {
                pop(context);
              },
              child: CustomTitle(text: 'Log In from here')),
        ],
      ),
    );
  }
}
