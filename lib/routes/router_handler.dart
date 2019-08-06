import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:hanplus_flutter/index/index.dart';
import 'package:hanplus_flutter/screen/detail.dart';
import 'package:hanplus_flutter/screen/entry.dart';

import 'package:hanplus_flutter/screen/home.dart';
import 'package:hanplus_flutter/screen/login.dart';
import '../models/response/product_response_model.dart';

var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new HomePage();
  },
);

var entryHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new Entry();
  },
);

var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new Login();
  },
);

var detailHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<dynamic>> params) {
      String token = params['token']?.first;
  String id = params['id']?.first;
    return new Detail(id: id, token: token,);
  },
);

var indexHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new Index();
  },
);

// var categoryHandler = new Handler(
//   handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//     String name = params["type"]?.first;

//     return new CategoryHome(name);
//   },
// );

// var widgetNotFoundHandler = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return new WidgetNotFound();
// });

// var fullScreenCodeDialog = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   String path = params['filePath']?.first;
//   return new FullScreenCodeDialog(
//     filePath: path,
//   );
// });

// var webViewPageHand = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   String title = params['title']?.first;
//   String url = params['url']?.first;
//   return new WebViewPage(url, title);
// });
