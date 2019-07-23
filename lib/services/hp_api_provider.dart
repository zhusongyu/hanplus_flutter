import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';
import 'package:hanplus_flutter/manager/user_manager.dart';
import 'package:hanplus_flutter/models/response/category_response_model.dart';
import 'package:hanplus_flutter/models/response/login_response_model.dart';
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
    ResultData response = await httpManager.netFetch(
        "https://osorderapi.hanxiangyx.com/v1/users/login",
        {"email": email, "password": password},
        {
          "User-Agent":
              "com.handeson.os/HanPlus/1.0.0-6 (iPhone; U; OS 12.2; en-GB)"
        },
        Options(
            method: "POST",
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));
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
              contentType:
                  ContentType.parse("application/x-www-form-urlencoded")));
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
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));
    int cc = response.code;
    var data = response.data;
    print('userreponse = $data');
    // print([CategoryResponseModel.fromJson(data)]);
    return Future.value(CategoryResponseModel.fromJson(data));
  }
}
