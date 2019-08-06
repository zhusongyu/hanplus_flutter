import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hanplus_flutter/screen/detail.dart';
import 'package:hanplus_flutter/screen/entry.dart';
import 'package:hanplus_flutter/screen/entry.dart' as prefix0;
import 'package:hanplus_flutter/screen/home.dart';
import 'package:hanplus_flutter/screen/login.dart';
import '../index/index.dart';

class RoutePaths {
  static const String Login = 'login';
  static const String Entry = 'entry';
  static const String Index = 'index';
  static const String Detail = 'detail';
  static const String Home = 'home';
}

// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RoutePaths.Entry:
//         return CupertinoPageRoute(builder: (context) {
//           ScreenUtil.instance = ScreenUtil(width: 375, height: 667)
//             ..init(context);
//           return Entry();
//         });
//       case RoutePaths.Login:
//         return CupertinoPageRoute(builder: (_) => Login());
//       case RoutePaths.Index:
//         return CupertinoPageRoute(builder: (_) => Index());
//       case RoutePaths.Detail:
//         return CupertinoPageRoute(builder: (_) => Detail(), settings: settings);
//       case RoutePaths.Home:
//         return CupertinoPageRoute(builder: (_) => HomePage());
//       default:
//         return MaterialPageRoute(
//             builder: (_) => Scaffold(
//                   body: Center(
//                     child: Text('No route defined for ${settings.name}'),
//                   ),
//                 ));
//     }
//   }
// }
