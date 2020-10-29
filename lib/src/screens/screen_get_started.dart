import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/assets.dart';
import 'package:flutter_projects/src/data/public_function.dart';
import 'package:flutter_projects/src/screens/screens.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 9,
              child: RoundedContainer(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  child: Column(
                    children: [
                      Expanded(
                        child: ScrollableColumn(
                          children: [
                            ArabicTitle(
                              text: 'أهلا وسهلا بك',
                              size: 20,
                              isBold: true,
                              color: Color(0xff242426),
                            ),
                            ArabicTitle(
                              text: 'في تطبيق دكتورك !',
                              size: 20,
                              isBold: false,
                              color: Color(0xff242426),
                            ),
                            Image.asset(Assets.helloMessage),
                          ],
                        ),
                      ),
                      RoundedButton(
                        onPress: () => push(context, LogInScreen()),
                        title: 'تسجيل الدخول',
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        fontColor: Colors.white,
                      ),
                      RoundedOutLineButton(
                        onPress: () => push(context, SignUpScreen()),
                        title: 'تسجيل جديد',
                        borderColor: Theme.of(context).scaffoldBackgroundColor,
                        backgroundColor: Colors.white,
                        fontColor: Theme.of(context).scaffoldBackgroundColor,
                        borderWidth: 1,
                      )
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
