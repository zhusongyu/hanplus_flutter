import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// header拦截器
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    ///超时
    options.connectTimeout = 15000;
    return options;
  }
}
