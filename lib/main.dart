import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/screen/screens.dart';
import 'src/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: applicationTitle,
      theme: ThemeData(primarySwatch: red),
      home: Navigation(),
    );
  }
}
