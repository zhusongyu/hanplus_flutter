import 'dart:convert';
import 'package:json_serializable/json_serializable.dart';

class LoginResponseModel {
  String token;
  LoginResponseModel({
    this.token,
  });
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      new LoginResponseModel(
        token: json["token"],
      );
}
