import 'dart:collection';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'package:hanplus_flutter/services/hp_api_provider.dart';
import 'package:hanplus_flutter/models/response/product_response_model.dart';
import '../shared/palette.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';

class BuyspeedPage extends StatefulWidget {
  const BuyspeedPage({Key key}) : super(key: key);
  @override
  State createState() => _BuySpeedState();
}

class _BuySpeedState extends State<BuyspeedPage> {
  ProductResponseModel _productModels;
  var _pref = SharedPref.create();

  // var _productNumMap = {0: 0};

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '极速购',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(15, 7, 15, 0),
                          child: Text.rich(TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: '合计：',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            TextSpan(
                                text: 'NT\$' + totalMoney(),
                                style: TextStyle(
                                    color: Palette.pastelRed,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))
                          ]))
                          // Text(
                          //   '合计：' + totalMoney(),
                          // ),
                          ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          '净值：' + totalVp(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    saveProduct();
                  },
                  padding: EdgeInsets.all(0),
                  child: Container(
                    width: 130,
                    height: 49,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Palette.peach, Palette.pastelRed])),
                    child: Text(
                      '立即购买',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(index);
            },
            itemCount: _productModels != null ? _productModels.data.length : 0,
            itemExtent: 50,
          ),
        )
      ],
    );
  }

  Widget _buildItem(int index) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 250,
                child: Text(
                  _productModels.data != null
                      ? _productModels.data[index].name
                      : '',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 22,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 22,
                      height: 22,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_productModels.data != null &&
                                _productModels.data[index].number > 0) {
                              _productModels.data[index].number--;
                            }
                          });
                        },
                        padding: EdgeInsets.all(0),
                        icon: ImageFactory.reduceIcon,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      width: 32,
                      height: 22,
                      alignment: Alignment.center,
                      child: Text(
                        _productModels.data != null
                            ? _productModels.data[index].number.toString()
                            : '0',
                        style: TextStyle(),
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_productModels.data != null &&
                                _productModels.data[index].number <
                                    _productModels.data[index].stock) {
                              _productModels.data[index].number++;
                            }
                          });
                        },
                        padding: EdgeInsets.all(0),
                        icon: ImageFactory.addIcon,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          height: 1,
          bottom: 0,
          left: 0,
          right: 0,
          child: Divider(),
        )
      ],
    );
  }

  getProduct([int categoryId, String keyword, String productIds]) async {
    ProductResponseModel model =
        await HPAPIProvider().getProduct(categoryId, keyword, productIds);
    setState(() {
      _productModels = model;
    });
  }

  String totalMoney() {
    var total = Decimal.fromInt(0);
    if (_productModels != null) {
      _productModels.data.forEach((model) {
        total =
            total + Decimal.parse(model.price) * Decimal.fromInt(model.number);
      });
    }

    return total.toString();
  }

  String totalVp() {
    var total = Decimal.fromInt(0);
    if (_productModels != null) {
      _productModels.data.forEach((model) {
        total = total + Decimal.parse(model.vp) * Decimal.fromInt(model.number);
      });
    }

    return total.toString();
  }

  saveProduct() async {
    final SharedPref pref = await _pref;
    ProductResponseModel newModels = ProductResponseModel(data: []);
    _productModels.data.forEach((model) {
      if (model.number > 0) {
        newModels.data.add(model);
      }
    });
    pref.saveProduct(newModels);
  }
}
