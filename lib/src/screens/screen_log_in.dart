import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/assets.dart';
import 'package:flutter_projects/src/data/public_function.dart';
import 'package:flutter_projects/src/screens/screen_home.dart';
import 'package:flutter_projects/src/screens/screens.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: MyAppBar(title: 'تسجيل دخول')),
            Expanded(
              flex: 9,
              child: RoundedContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ScrollableColumn(
                    children: [
                      SizedBox(height: 15),
                      Image.asset(Assets.signIn),
                      InputTextField(
                          title: 'البريد الإلكتروني',
                          keyboardType: TextInputType.emailAddress),
                      InputTextField(
                          title: 'كلمة المرور',
                          keyboardType: TextInputType.visiblePassword),
                      SizedBox(height: 15),
                      RoundedButton(
                        onPress: () => push(context, Home()),
                        title: 'تسجيل الدخول',
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        fontColor: Colors.white,
                      ),
                      SizedBox(height: 15),
                      MySpanText('لا تمتلك حساب؟', 'تسجيل جديد',
                          () => pushReplacement(context, SignUpScreen())),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
