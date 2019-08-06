import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:hanplus_flutter/models/response/product_response_model.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';
import 'package:hanplus_flutter/screen/home.dart';

class Detail extends StatelessWidget {
    final String token;
  final String id;

  const Detail({Key key, this.token, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final RouteParamsOfDetail _params =
        // ModalRoute.of(context).settings.arguments;

    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(title: Text('详情'),),
      url: 'https://osappweb.hanxiangyx.com/product/detail?region=HK&token=$token&product_id=$id',
    );
    // return Text('data');
  }
}
