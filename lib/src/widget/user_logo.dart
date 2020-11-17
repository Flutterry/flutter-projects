import 'package:flutter/material.dart';
import 'package:flutter_projects/src/blocs/blocs.dart';
import 'package:flutter_projects/src/model/models.dart';
import 'package:flutter_projects/src/utils/utils.dart';

class UserLogo extends StatelessWidget {
  final String userId;


  UserLogo(this.userId);

  @override
  Widget build(BuildContext context) {
    final userBloc = UserBloc();
    userBloc.userIdSink(userId);
    return  StreamBuilder(
      stream: userBloc.userStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data;
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: user.onLine ? Colors.green : Colors.red,
                  ),
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Palette.scaffoldColor,
                  ),
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: user.onLine ? Colors.green : Colors.red,
                    backgroundImage: NetworkImage(user.image),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                user.name,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
              ),
            ],
          );
        } else {
          return    Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.red,
              ),
              CircleAvatar(
                radius: 48,
                backgroundColor: Palette.scaffoldColor,
              ),
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.green,
              ),
            ],
          );
        }
      },
    );
  }
}