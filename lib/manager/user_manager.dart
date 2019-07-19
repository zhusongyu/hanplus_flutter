import 'dart:async';

import 'package:hanplus_flutter/models/response/login_response_model.dart';
import 'package:hanplus_flutter/services/hp_api_provider.dart';

class UserManager {
  final HPAPIProvider _api;
  UserManager({HPAPIProvider api}) : _api = api;

    Future<LoginResponseModel> loginWith({String name, String password}) async {
          LoginResponseModel account = await _api.login(email: name, password: password);
          print("account==$account");
    return account;
  }
}