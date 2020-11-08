import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/models/user.dart';
import 'package:flutter_projects/src/presenters/store_presenter.dart';
import 'package:flutter_projects/src/public_helper/helper.dart';
import 'package:flutter_projects/src/screens/screen_conversation.dart';
import 'package:flutter_projects/src/widgets/widget_loading.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios), onPressed: () => pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: StorePresenter().getUsersByName(query),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var suggestions = <User>[];
          for (var doc in snapshot.data.docs) {
            var user = User.fromFirebase(doc);
            suggestions.add(user);
          }
          if (suggestions.isEmpty)
            return Center(
                child: Text(
                    'there is no user with that name please try again later'));
          return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                var user = suggestions[index];
                return Card(
                  child: ListTile(
                    onTap: () => pushReplacement(context, Conversation()),
                    contentPadding: EdgeInsets.only(right: 10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                      radius: 50,
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.status),
                    trailing: CircleAvatar(
                      radius: 3,
                      backgroundColor: user.onLine ? Colors.green : Colors.red,
                    ),
                  ),
                );
              });
        } else {
          return Loading();
        }
      },
    );
  }
}
