import 'package:hanplus_flutter/models/response/product_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SharedPrefBuilder = Future<SharedPreferences> Function();

class SharedPref {
  SharedPreferences _prefs;
  SharedPref._(this._prefs);

  static Future<SharedPref> create() async =>
      SharedPref._(await SharedPreferences.getInstance());

  String getToken() {
    var value = _prefs.getString("token");
    return value;
  }

  saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  removeToken() async {
    await _prefs.remove('token');
  }

  saveProduct(ProductResponseModel model) async {
    await _prefs.setString('product', model.toRawJson());
  }

  ProductResponseModel getProduct() {
    final value = _prefs.getString('product');
    if (value != null) {
      return ProductResponseModel.fromRawJson(value);
    }
    return null;
  }
}
