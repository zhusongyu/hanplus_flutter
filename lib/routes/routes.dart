import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hanplus_flutter/screen/entry.dart';
import 'package:hanplus_flutter/screen/login.dart';
import '../index/index.dart';

class RoutePaths {
  static const String Login = '/login';
  static const String Entry = '/';
    static const String Index = '/index';
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Entry:
        return CupertinoPageRoute(builder: (_) => Entry());
      case RoutePaths.Login:
        return CupertinoPageRoute(builder: (_) => Login());
              case RoutePaths.Index:
        return CupertinoPageRoute(builder: (_) => Index());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
