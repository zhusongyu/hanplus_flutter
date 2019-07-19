import 'package:flutter/material.dart';
import 'package:hanplus_flutter/models/response/login_response_model.dart';
import 'package:hanplus_flutter/setup.dart';
import 'package:hanplus_flutter/shared/palette.dart';
import 'package:hanplus_flutter/screen/entry.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'package:hanplus_flutter/widget/hp_textfield.dart';
import 'package:hanplus_flutter/widget/hp_button.dart';
import 'package:hanplus_flutter/services/hp_api_provider.dart';
import 'package:hanplus_flutter/manager/user_manager.dart';
import 'package:hanplus_flutter/services/request.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hanplus_flutter/routes/routes.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _nameTextEditController = TextEditingController();
  final _pwdTextEditController = TextEditingController();
  bool _loadingVisibility = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Palette.aquaBlue, Palette.tealBlue])),
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 45),
          GestureDetector(
            child: ImageFactory.iconBack,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 45),
          Container(
            child: Text(
              '会员登录',
              style:
                  TextStyle(color: Colors.white, fontSize: 28, inherit: false),
            ),
          ),
          SizedBox(height: 35),
          HPTextField(
            hitText: '请填写会员号',
            textEditingController: _nameTextEditController,
          ),
          SizedBox(height: 10),
          HPTextField(
            hitText: '请填写密码',
            textEditingController: _pwdTextEditController,
          ),
          SizedBox(height: 24),
          HPButton(
            buttonTitle: '登录',
            onTap: () {
              loginBtnClick();
            },
          ),
          SizedBox(height: 12.5),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                getUserBtnClick();
              },
              child: Text('忘记密码？',
                  style: TextStyle(
                      color: Colors.white70, inherit: false, fontSize: 14)),
            ),
          )
        ],
      ),
    );
  }

  void loginBtnClick() async {
    if (_nameTextEditController.text.length <= 0) {
      showAlertDialog(context, '登录账号不能为空');
      return;
    }
    if (_pwdTextEditController.text.length <= 0) {
      showAlertDialog(context, '密码不能为空');
      return;
    }
    HPAPIProvider().login(
        email: _nameTextEditController.text,
        password: _pwdTextEditController.text, callback: () {
                                Navigator.of(context).pushNamed(RoutePaths.Index);

        });
  }

  void getUserBtnClick() async {
    HPAPIProvider().getUser();
  }

  void showAlertDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              content: Text(content),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('知道了'),
                ),
              ],
            ));
  }
}
