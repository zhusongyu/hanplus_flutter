import 'package:flutter/material.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'dart:ui';
import 'package:hanplus_flutter/shared/palette.dart';
import 'package:hanplus_flutter/routes/routes.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';
import 'package:hanplus_flutter/routes/routers.dart';
import '../routes/application.dart';
import 'package:fluro/fluro.dart';

  final width = window.physicalSize.width;
  final height = window.physicalSize.height;
class Entry extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.passthrough,
      children: <Widget>[
        Image.asset(
          'res/assets/bg.png',
          fit: BoxFit.fill,
          width: width/2,
          height: height/2,
        ),
        Padding(
          padding: EdgeInsets.only(top: 190),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageFactory.logo,
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    onTap: () {
                          Application.router.navigateTo(context, Routes.Login, transition: TransitionType.inFromRight);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Palette.aquaBlue, Palette.tealBlue])),
                      height: 48,
                      alignment: Alignment.center,
                      child: Text(
                        '会员登录',
                        style: TextStyle(
                            color: Colors.white, fontSize: 17, inherit: false),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white54),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 48,
                        alignment: Alignment.center,
                        child: Text(
                          '会员加入',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              inherit: false),
                        ),
                      ),
                    )),
              )
            ],
          ),
        )
        // Padding(
        //   padding: EdgeInsets.only(top: 20),
        //   child: ImageFactory.logo,
        // )
      ],
    );
  }
}

