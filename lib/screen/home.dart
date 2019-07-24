import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:hanplus_flutter/models/response/category_response_model.dart';
import 'package:hanplus_flutter/models/response/product_response_model.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'dart:ui';
import 'package:hanplus_flutter/services/hp_api_provider.dart';

import 'package:hanplus_flutter/shared/palette.dart';

final width = window.physicalSize.width;
final height = window.physicalSize.height;
var selectIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController;
  CategoryResponseModel _categoryModels;
  ProductResponseModel _productModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Palette.whiteThree,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'res/assets/headBg.png',
            fit: BoxFit.fill,
            width: width / 2,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                        child: Row(
                      children: <Widget>[
                        Text(
                          '台北',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              inherit: false),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ImageFactory.more,
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            // textAlignVertical: TextAlignVertical.bottom,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            controller: textEditingController,
                            decoration: InputDecoration(
                                hintText: "搜索商品关键词",
                                hintStyle: TextStyle(
                                    color: Colors.white70, fontSize: 14),
                                icon: ImageFactory.search,
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
                Container(
                  height: (width / 2 - 30) / 345 * 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Image.asset(
                        'res/assets/banner01.png',
                        fit: BoxFit.fill,
                      ),
                      Image.asset(
                        'res/assets/banner01.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 15,
                  runSpacing: 10,
                  children: _buildClassify(),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: _buildProductList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildClassify() {
    List<Widget> widgets = [];
    if (_categoryModels != null) {
      _categoryModels.data.asMap().forEach((index, model) {
        Widget child = ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = index;
                });
              },
              child: Container(
                width: 75,
                height: 32,
                color: Palette.veryLightPink,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    selectIndex == index ? ImageFactory.allClassify : Text(""),
                    Text(
                      model.name,
                      style: TextStyle(
                          color: selectIndex == index
                              ? Colors.white
                              : Palette.black30,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
            ));
        widgets.add(child);
      });
    } else {
      widgets.add(Text('dada'));
    }
    return widgets;
  }

  List<Widget> _buildProductList() {
    List<Widget> widgets = [Text('')];
    if (_productModels != null) {
      _productModels.data.forEach((ele) {
        Widget widget = Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    height: 230,
                    width: width,
                    imageUrl: ele.picture,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 10, 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(ele.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, color: Palette.blackTwo)),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Text('NT\$${ele.price}',
                                style: TextStyle(
                                    fontSize: 21, color: Palette.pastelRed)),
                            SizedBox(
                              width: 8.5,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Palette.tealBlue10,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                '净值:22',
                                style: TextStyle(
                                    fontSize: 12, color: Palette.tealBlue),
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              'res/assets/shopCart.png',
                              fit: BoxFit.fill,
                              height: 40,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        );
        widgets.add(widget);
      });
    }

    return widgets;
  }

  getCategory() async {
    CategoryResponseModel model = await HPAPIProvider().getCategory();
    setState(() {
      _categoryModels = model;
    });
  }

  getProduct() async {
    ProductResponseModel model = await HPAPIProvider().getProduct();
    setState(() {
      _productModels = model;
    });
  }
}
