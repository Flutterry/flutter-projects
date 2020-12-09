import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/src/utils.dart';
import 'package:flutter_projects/src/widget/custom_title.dart';

class MyDrawer extends StatelessWidget {
  User get user => FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Widget tile(IconData icon, String title, void Function() onTap) {
      return ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          pop(context);
          onTap();
        },
      );
    }

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: red),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(text: user.displayName ?? '', size: 20),
                CustomTitle(
                    text: user.email,
                    size: 18,
                    color: Colors.white.withOpacity(.7)),
              ],
            ),
          ),
          tile(Icons.home, 'Home', () {}),
          tile(Icons.fastfood, 'Food I Like', () {}),
          tile(Icons.restaurant, 'Liked restaurant', () {}),
          tile(Icons.bookmark_border, 'My Orders', () {}),
          tile(Icons.shopping_cart, 'Cart', () {}),
          tile(Icons.settings, 'Settings', () {}),
        ],
      ),
    );
  }
}
