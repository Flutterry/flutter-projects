import 'package:flutter/material.dart';
import 'package:flutter_projects/src/models/doctor.dart';

import 'widgets.dart';

class FullDoctorCard extends StatelessWidget {
  final Doctor doctor;
  final double cardWidth;

  FullDoctorCard(this.cardWidth, this.doctor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      child: Stack(
        children: [
          DoctorCard(width: cardWidth, child: DoctorInfo(doctor)),
          Positioned(
            top: 15,
            right: 0,
            left: 0,
            child: DoctorImage(doctor.user.imageUrl),
          ),
        ],
      ),
    );
  }
}

class DoctorImage extends StatelessWidget {
  final String image;

  DoctorImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 60,
        ),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], offset: Offset(4, 6), blurRadius: 5)
          ]),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  final Doctor doctor;

  DoctorInfo(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _DoctorRowInfo(
          DoctorOnline(doctor.user.isOnline),
          ArabicTitle(
            text: doctor.user.name,
            size: 20,
            isBold: true,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        _DoctorRowInfo(
          ArabicTitle(
            text: doctor.offerPrice.toString() + '\$',
            size: 16,
            isBold: true,
            color: Colors.red,
          ),
          ArabicTitle(
            text: doctor.special,
            size: 12,
            isBold: true,
            color: Colors.grey,
          ),
        ),
        _DoctorRowInfo(
          ArabicTitle(
              text: doctor.price.toString() + '\$',
              size: 14,
              isBold: true,
              color: Colors.red,
              withLine: true),
          MyRating(doctor.rate),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}

class _DoctorRowInfo extends StatelessWidget {
  final Widget child1, child2;

  _DoctorRowInfo(this.child1, this.child2);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        child1,
        child2,
      ],
    );
  }
}

class DoctorCard extends StatelessWidget {
  final double width;
  final child;

  DoctorCard({this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 220,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}

class DoctorOnline extends StatelessWidget {
  final bool isOnline;

  DoctorOnline(this.isOnline);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                  color: isOnline ? Colors.green[700] : Colors.red[700])),
        ),
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: isOnline ? Colors.green[700] : Colors.red[700],
            shape: BoxShape.circle,
          ),
        )
      ],
    );
  }
}
