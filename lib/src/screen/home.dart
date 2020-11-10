import 'package:flutter/material.dart';
import '../presenter/auth_presenter.dart';
import 'screens.dart';
import '../utils/utils.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('out'),
          onPressed: () async {
            await AuthPresenter().signOut();
            Nav.pushClear(context, GetStarted());
          },
        ),
      ),
    );
  }
}
