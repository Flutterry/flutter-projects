import 'package:flutter/material.dart';
import '../utils.dart';
import 'widgets.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    @required this.notificationNumber,
    @required this.onPress,
  });

  final int notificationNumber;
  final void Function() onPress;

  String getNotificationText() =>
      (notificationNumber < 10) ? notificationNumber.toString() : '+9';

  double getFontSize() => (notificationNumber < 10) ? 10 : 8;

  double getBatchPadding() => (notificationNumber < 10) ? 4 : 2;

  @override
  Widget build(BuildContext context) {
    var icon = Padding(
      padding: EdgeInsets.all(10),
      child: Icon(Icons.notifications_none),
    );

    var widget = (notificationNumber == 0)
        ? icon
        : Stack(
            children: [
              icon,
              Positioned(
                right: 7,
                top: 7,
                child: Container(
                  padding: EdgeInsets.all(getBatchPadding()),
                  decoration: BoxDecoration(color: red, shape: BoxShape.circle),
                  child: Center(
                    child: CustomTitle(
                      text: getNotificationText(),
                      size: getFontSize(),
                      weight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
              )
            ],
          );

    return GestureDetector(child: widget, onTap: onPress);
  }
}
