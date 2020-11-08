import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presenters/search_delegate.dart';
import '../cubit/is_loading.dart';
import '../presenters/auth_presenter.dart';
import '../public_helper/helper.dart';
import 'screens.dart';
import '../widgets/widgets.dart';

class ChatRoom extends StatelessWidget {
  var authPresenter = AuthPresenter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsLoading, bool>(
        builder: (context, state) => state ? Loading() : _Screen());
  }
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkColor,
        child: Icon(Icons.search, color: Colors.white),
        onPressed: () {
          showSearch(context: context, delegate: Search());
        },
      ),
      body: Center(
        child: RaisedButton(
          child: Text('sign out'),
          onPressed: () async {
            await AuthPresenter().signOut();
            pushClear(context, GetStarted());
          },
        ),
      ),
    );
  }
}
