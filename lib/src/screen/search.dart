import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/models.dart';
import '../presenter/presenters.dart';
import 'screens.dart';
import '../utils/utils.dart';
import '../widget/widgets.dart';

//todo complete search feature
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void clear() {}

  void search(String query) {}

  Widget buildSearchTile() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    var data = snapshot.data.docs;
                    if (data.isEmpty)
                      return Center(child: Text('there is no users yet'));
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => buildItem(data[index]),
                    );
                  } else {
                    return Center(child: Text('there is no users yet'));
                  }
                } else {
                  return Loading();
                }
              })),
    );
  }

  Widget buildItem(DocumentSnapshot data) {
    var user = UserModel.fromFirebaseSnapshot(data);
    if(user.id == AuthPresenter().currentUser.uid) return SizedBox.shrink();
    return Card(
      margin: EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: ListTile(
        onTap: () => Nav.pushReplace(context, ChatRoom(user.id)),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        title: Text(user.name),
        subtitle: Text(user.status),
        leading:
            CircleAvatar(backgroundImage: NetworkImage(user.image), radius: 30),
        trailing: CircleAvatar(
            backgroundColor: user.onLine ? Colors.green : Colors.red, radius: 5,),
      ),
    );
  }
}
