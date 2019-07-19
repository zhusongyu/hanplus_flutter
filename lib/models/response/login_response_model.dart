import 'dart:convert';

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
