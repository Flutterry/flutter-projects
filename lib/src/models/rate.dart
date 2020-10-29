import 'package:flutter_projects/src/models/user.dart';

class Rate {
  final User user;
  final int rate;
  final String date, comment;

  Rate({this.user, this.rate, this.date, this.comment});
}
