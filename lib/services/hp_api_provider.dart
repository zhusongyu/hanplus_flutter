import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';
import 'package:hanplus_flutter/manager/user_manager.dart';
import 'package:hanplus_flutter/models/response/category_response_model.dart';
import 'package:hanplus_flutter/models/response/decoration_response_model.dart';
import 'package:hanplus_flutter/models/response/login_response_model.dart';
import 'package:hanplus_flutter/models/response/product_response_model.dart';
import 'package:hanplus_flutter/models/response/user_response_model.dart';
import 'package:hanplus_flutter/services/hp_api.dart';
import 'dart:convert';

import 'package:hanplus_flutter/services/request.dart';
import 'package:hanplus_flutter/services/result_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HPAPIProvider extends HPAPI {
  var _pref = SharedPref.create();
  @override
  Future<LoginResponseModel> login(
      {String email, String password, VoidCallback callback}) async {
    final SharedPref pref = await _pref;
    // try {
    var options = Options(
            method: "POST",
            contentType: ContentType.parse("application/x-www-form-urlencoded"));
    ResultData response = await httpManager.netFetch(
        "https://osorderapi.hanxiangyx.com/v1/users/login",
        {"email": email, "password": password},
        {
          "User-Agent":
              "com.handeson.os/HanPlus/1.0.0-6 (iPhone; U; OS 12.2; en-GB)"
        },
        options);
    var data = response.data;
    var token = LoginResponseModel.fromJson(data).token;
    pref.saveToken(token);
    callback();
    return Future.value(LoginResponseModel.fromJson(data));
    // } catch (e) {
    //   print(e);
    //   return Future.value(LoginResponseModel());
    // }
  }

  Future<UserResponseModel> getUser() async {
    final SharedPref pref = await _pref;
    var token = pref.getToken();
    try {
      print('pref.getToken() $token');
      ResultData response = await httpManager.netFetch(
          "https://osorderapi.hanxiangyx.com/v1/users",
          null,
          {"Authorization": 'Bearer $token'},
          Options(
              method: "GET",
              contentType: ContentType.parse(HttpManager.CONTENT_TYPE_JSON)));
      int cc = response.code;
      var data = response.data;
      print('userreponse = $data');
      return Future.value(UserResponseModel.fromJson(data));
    } catch (e) {
      print(e);
      return Future.value(UserResponseModel());
    }
  }

  Future<CategoryResponseModel> getCategory() async {
    final SharedPref pref = await _pref;
    var token = pref.getToken();
    print('pref.getToken() $token');
    ResultData response = await httpManager.netFetch(
        "https://osorderapi.hanxiangyx.com/v1/products/category",
        null,
        {"Authorization": 'Bearer $token'},
        Options(
            method: "GET",
            contentType: ContentType.parse(HttpManager.CONTENT_TYPE_JSON)));
    var data = response.data;
    print('userreponse = $data');
    // print([CategoryResponseModel.fromJson(data)]);
    return Future.value(CategoryResponseModel.fromJson(data));
  }

  Future<ProductResponseModel> getProduct(
      [int categoryId, String keyword, String productIds]) async {
    final SharedPref pref = await _pref;
    var token = pref.getToken();
    var url = 'https://osorderapi.hanxiangyx.com/v1/products/product?region=HK';
    if (categoryId != null) {
      url = url + '&category_id=${categoryId.toString()}';
    }
    if (keyword != null) {
      url = url + '&keyword=$keyword';
    }
    if (productIds != null) {
      url = url + '&product_ids=$productIds';
    }

    ResultData response = await httpManager.netFetch(
        url,
        null,
        {"Authorization": 'Bearer $token'},
        Options(
          method: "get",
        ));
    var data = response.data;
    print('userreponse = $data');
    // print([CategoryResponseModel.fromJson(data)]);
    return Future.value(ProductResponseModel.fromJson(data));
  }

  Future<DecorationResponseModel> getDecoration(String name) async {
    final SharedPref pref = await _pref;
    var token = pref.getToken();
    String url =
        'https://osorderapi.hanxiangyx.com/v1/api/decorations/decoration?region=HK&name=$name';

    ResultData response = await httpManager.netFetch(
        url,
        null,
        {"Authorization": 'Bearer $token'},
        Options(
            method: "GET",
            contentType: ContentType.parse(HttpManager.CONTENT_TYPE_JSON)));
    var data = response.data;
    print('userreponse = $data');
    // print([CategoryResponseModel.fromJson(data)]);
    return Future.value(DecorationResponseModel.fromJson(data));
  }
}
