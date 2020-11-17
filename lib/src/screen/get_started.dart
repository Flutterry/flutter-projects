import 'package:flutter/material.dart';

import '../presenter/auth_presenter.dart';
import '../utils/utils.dart';
import '../widget/widgets.dart';
import 'screens.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()async{
      await Future.delayed(Duration(seconds: 2));
      var auth = AuthPresenter();
      if(auth.checkUser()){
       Nav.pushClear(context, Home());
      }else{
       Nav.pushReplace(context, SignIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(),
            HeroCircle(
                radius: deviceSize.width,
                heroTag: KaT.heraTagBottomCircle,
                color: Palette.darkColor,
                type: Type.bottom),
            HeroCircle(
                radius: deviceSize.width / 2,
                heroTag: KaT.heraTagTopCircle,
                color: Palette.darkColor,
                type: Type.top),
            HeroCircle(
                radius: deviceSize.width / 3,
                heroTag: KaT.heraTagCenterRightCircle,
                color: Palette.scaffoldColor.withOpacity(.2),
                type: Type.centerRight),
            TextShadow(
              text: 'Phoenix Chat',
              fontSize: 45,
            )
          ],
        ),
      ),
    );
  }
}
