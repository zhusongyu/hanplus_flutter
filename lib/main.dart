import 'package:flutter/material.dart';
import 'package:hanplus_flutter/routes/application.dart';
import 'package:hanplus_flutter/screen/entry.dart';
import 'package:hanplus_flutter/screen/home.dart';
import 'package:hanplus_flutter/routes/routes.dart';
import 'package:hanplus_flutter/setup.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';
import 'package:hanplus_flutter/index/index.dart';
import 'package:fluro/fluro.dart';
import 'package:hanplus_flutter/routes/routers.dart';

var routePath = RoutePaths.Entry;
void main() async {
  setupLog();
  // await setupLocator();
  _rootPage();
}

class MyAppEntry extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
            home: Entry(),
      initialRoute: RoutePaths.Entry,
      // onGenerateRoute: Routes.generateRoute,
    );
  }
}

class MyAppIndex extends StatelessWidget {
  // This widget is the root of your application.
  //   MyAppIndex()  {
  //   final router = new Router();

  //   Routes.configureRoutes(router);

  //   Application.router = router;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Index(),
      // initialRoute: RoutePaths.Home,
      onGenerateRoute: Application.router.generator//Routes.generateRoute,
    );
  }
}

_rootPage() async {
      final router = new Router();

    Routes.configureRoutes(router);

    Application.router = router;
  var _pref = SharedPref.create();

  final SharedPref pref = await _pref;
  var token = pref.getToken();
  if (token != null) {
      runApp(MyAppIndex());
  } else {
      runApp(MyAppEntry());
  }
}
