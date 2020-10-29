import 'package:flutter_projects/src/models/rate.dart';
import 'package:flutter_projects/src/models/user.dart';

class Doctor {
  final User user;
  final String special, language, bio, education;
  final int rate, price, offerPrice, numberOfUserRated;
  final List<Rate> usersRate;

  Doctor({
    this.education,
    this.bio,
    this.numberOfUserRated,
    this.usersRate,
    this.user,
    this.price,
    this.offerPrice,
    this.rate,
    this.special,
    this.language,
  });
}
