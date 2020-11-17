import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/navigation.dart';
import '../widget/widgets.dart';
import 'screens.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var border = Radius.circular(40.0);
    return Scaffold(
        backgroundColor: Palette.darkColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          Nav.push(context, Search());
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.call_missed, color: Colors.white),
                        onPressed: ()async {
                          await FirebaseAuth.instance.signOut();
                          Nav.pushClear(context, GetStarted());                        },
                      ),
                    ),
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: border,
                    topRight: border,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: border,
                        topRight: border,
                      ),
                      color: Colors.white,
                    ),
                    child: CustomScrollView(slivers: [
                      SliverToBoxAdapter(child: OnlineUsers()),
                      ChatRooms(),
                    ]),
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ));
  }
}
