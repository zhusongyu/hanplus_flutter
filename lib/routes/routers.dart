import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './router_handler.dart';

class Routes {
  static const String Login = 'login';
  static const String Entry = 'entry';
  static const String Index = 'index';
  static const String Detail = 'detail';
  static const String Home = 'home';

  static void configureRoutes(Router router) {
    // List widgetDemosList = new WidgetDemoList().getDemos();
    // router.notFoundHandler = new Handler(
    //     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    //     });
    // router.define(home, handler: homeHandler);

    router.define(Login, handler: loginHandler);
    router.define(Entry, handler: entryHandler);
    router.define(Index, handler: indexHandler);
    router.define(Detail, handler: detailHandler);
    router.define(Home, handler: homeHandler);

    // router.define(webViewPage,handler:webViewPageHand);
    //   widgetDemosList.forEach((demo) {
    //     Handler handler = new Handler(
    //         handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    //           print('组件路由params=$params widgetsItem=${demo.routerName}');
    //           analytics.logEvent(
    //               name: 'component', parameters: {'name': demo.routerName });
    //           return demo.buildRouter(context);
    //   });
    //   router.define('${demo.routerName}', handler: handler);
    // });
  }
}
