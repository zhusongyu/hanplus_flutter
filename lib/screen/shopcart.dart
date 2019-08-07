import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hanplus_flutter/models/response/product_response_model.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'package:hanplus_flutter/shared/palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';

class ShopcartPage extends StatefulWidget {
  const ShopcartPage({Key key}) : super(key: key);
  @override
  State createState() => _ShopcartState();
}

class _ShopcartState extends State<ShopcartPage> {
  var _pref = SharedPref.create();
  ProductResponseModel _productModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Palette.whiteThree,
        appBar: AppBar(
          title: Text(
            '购物车',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          // leading: Row(
          //   children: <Widget>[
          //     SizedBox(
          //       width: ScreenUtil.instance.setWidth(16),
          //     ),
          //     GestureDetector(
          //       onTap: () {},
          //       child: Row(
          //         children: <Widget>[
          //           Text(
          //             '台北',
          //             style: TextStyle(color: Colors.black, fontSize: 14),
          //           ),
          //           ImageFactory.moreIconBlack,
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          actions: <Widget>[
            GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '编辑',
                        style: TextStyle(color: Palette.tealBlue, fontSize: 17),
                      ),
                    ],
                  ),
                ))
          ],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(index);
          },
          itemExtent: 112,
          itemCount: _productModels != null ? _productModels.data.length : 0,
          padding: EdgeInsets.only(top: 3, bottom: 15),
        ));
  }

  Widget _buildItem(int index) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(15, 12, 15, 0),
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _productModels.data[index].selected =
                        !_productModels.data[index].selected;
                  });
                },
                child: _productModels.data[index].selected
                    ? ImageFactory.selectedIcon
                    : ImageFactory.unSelectIcon,
              ),
              SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  height: 70,
                  width: 70,
                  imageUrl: _productModels.data[index].picture,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _productModels.data[index].name,
                    ),
                    SizedBox(
                      height: 6.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Palette.tealBlue10,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1))),
                              child: Text(
                                '净值:${_productModels.data[index].vp}',
                                style: TextStyle(
                                    fontSize: 12, color: Palette.tealBlue),
                              ),
                            ),
                            Text('NT\$${_productModels.data[index].price}',
                                style: TextStyle(
                                    fontSize: 14, color: Palette.pastelRed)),
                          ],
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
                                          _productModels.data[index].number >
                                              0) {
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
                                      ? _productModels.data[index].number
                                          .toString()
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
                                              _productModels
                                                  .data[index].stock) {
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
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ));
  }

  getProduct() async {
    final SharedPref pref = await _pref;
    setState(() {
      _productModels = pref.getProduct();
    });
  }
}
