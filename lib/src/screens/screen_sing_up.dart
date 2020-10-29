import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/public_function.dart';
import 'package:flutter_projects/src/screens/screens.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var gender;
  bool iAgree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 1, child: MyAppBar(title: 'تسجيل حساب جديد')),
            Expanded(
              flex: 9,
              child: RoundedContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ScrollableColumn(
                    children: [
                      SizedBox(height: 10),
                      InputTextField(
                          title: 'الاسم كاملا',
                          keyboardType: TextInputType.name),
                      InputTextField(
                          title: 'البريد الإلكتروني',
                          keyboardType: TextInputType.emailAddress),
                      InputTextField(
                          title: 'رقم الموبايل',
                          keyboardType: TextInputType.phone),
                      InputTextField(
                          title: 'كلمة المرور',
                          keyboardType: TextInputType.visiblePassword),
                      InputTextField(
                          title: 'تأكيد كلمة المرور',
                          keyboardType: TextInputType.visiblePassword),
                      GenderSelection((value) {
                        setState(() {
                          gender = value;
                        });
                      }, gender),
                      CheckboxListTile(
                        title: ArabicTitle(
                          text: 'أوافق على شروط الإستخدام',
                          size: 14,
                          color: Colors.black,
                          isBold: true,
                        ),
                        onChanged: (value) {
                          setState(() {
                            iAgree = value;
                          });
                        },
                        value: iAgree,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                            onPress: () {},
                            title: 'تسجيل جديد',
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            fontColor: Colors.white),
                      ),
                      MySpanText('هل تمتلك حساب؟ ', 'تسجيل دخول',
                          () => pushReplacement(context, LogInScreen()))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
