import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hanplus_flutter/models/response/category_response_model.dart';
import 'package:hanplus_flutter/models/response/decoration_response_model.dart';
import 'package:hanplus_flutter/models/response/product_response_model.dart';
import 'package:hanplus_flutter/routes/application.dart';
import 'package:hanplus_flutter/routes/routes.dart';
import 'package:hanplus_flutter/screen/detail.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'dart:ui';
import 'package:hanplus_flutter/services/hp_api_provider.dart';

import 'package:hanplus_flutter/shared/palette.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../pull_to_refresh_layout/pull_to_refresh_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../screen/detail.dart';
import 'package:hanplus_flutter/cache/shared_pref.dart';
import '../routes/routers.dart';

// final width = window.physicalSize.width;
// final height = window.physicalSize.height;
var selectIndex = 0;

class RouteParamsOfDetail {
  final ProductResponseDataModel model;
  final String token;

  RouteParamsOfDetail({@required this.model, @required this.token});
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController;
  var _categoryModels =
      CategoryResponseModel(data: [CategoryResponseDataModel(name: '全部')]);
  ProductResponseModel _productModels;
  DecorationResponseModel _decorationModels;
  ScrollController _scrollViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
    getProduct();
    getDecoration('APP');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // TODO: implement build
    return Material(
      color: Palette.whiteThree,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'res/assets/headBg.png',
            fit: BoxFit.fill,
            width: width,
          ),
          Container(
              padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
              child: _buildBody(context))
        ],
      ),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    // monitor network fetch
    getProduct();
    getCategory();
    await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use refreshFailed()
    // getCategory();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    super.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: _buildListView(context));
  }

  Widget _buildHeadView() {
    return Row(
      children: <Widget>[
        GestureDetector(
            child: Row(
          children: <Widget>[
            Text(
              '台北',
              style:
                  TextStyle(color: Colors.white, fontSize: 16, inherit: false),
            ),
            SizedBox(
              width: 5,
            ),
            ImageFactory.more,
            SizedBox(
              width: 10,
            ),
            Container(
              width: 200,
              child: TextField(
                // textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(color: Colors.white, fontSize: 14),
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "搜索商品关键词",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                    icon: ImageFactory.search,
                    border: InputBorder.none),
              ),
            )
          ],
        )),
      ],
    );
  }

  Widget _buildBannerView() {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        if (_decorationModels != null && _decorationModels.sliders.length > 0) {
          return CachedNetworkImage(
            // fit: BoxFit.fitWidth,
            imageUrl: _decorationModels.sliders[index].imgUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          );
        } else {
          return Image.asset(
            'res/assets/banner01.png',
            // fit: BoxFit.fitWidth,
          );
        }
      },
      itemCount:
          _decorationModels != null ? _decorationModels.sliders.length : 1,
      viewportFraction: 1,
      scale: 0.9,
      autoplay: _decorationModels != null ? true : false,
    );
  }

  Widget _buildListView(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _buildHeadView(),
        Container(height: (width - 30) / 345 * 130, child: _buildBannerView()),
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
          children: _buildProductList(context),
        )
      ],
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
                getProduct(model.id);
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
      widgets.add(Text(''));
    }
    return widgets;
  }

  List<Widget> _buildProductList(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    List<Widget> widgets = [Text('')];
    if (_productModels != null) {
      _productModels.data.forEach((ele) {
        Widget widget = Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  print('点击产品');
                  pushToDetail(context, ele);
                      // Navigator.pushNamed(context, RoutePaths.Detail);
                  // Navigator.of(context).push(CupertinoPageRoute(builder: (_) => Detail()));
                },
                child: ClipRRect(
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
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
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
                                        fontSize: 21,
                                        color: Palette.pastelRed)),
                                SizedBox(
                                  width: 8.5,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                      color: Palette.tealBlue10,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(1))),
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
                )),
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
    _categoryModels =
        CategoryResponseModel(data: [CategoryResponseDataModel(name: '全部')]);
    CategoryResponseModel model = await HPAPIProvider().getCategory();
    setState(() {
      _categoryModels.data.addAll(model.data);
    });
  }

  getProduct([int categoryId, String keyword, String productIds]) async {
    ProductResponseModel model =
        await HPAPIProvider().getProduct(categoryId, keyword, productIds);
    setState(() {
      _productModels = model;
    });
  }

  getDecoration(String name) async {
    DecorationResponseModel model = await HPAPIProvider().getDecoration(name);
    setState(() {
      _decorationModels = model;
    });
  }

  pushToDetail(BuildContext context, ProductResponseDataModel model) async {
    var _pref = SharedPref.create();

    final SharedPref pref = await _pref;
    var token = pref.getToken();
    Application.router.navigateTo(context, '${Routes.Detail}?token=$token&id=${model.id.toString()}', transition: TransitionType.inFromRight);
    // Navigator.pushNamed(context, RoutePaths.Detail,
    //     arguments: RouteParamsOfDetail(model: model, token: token));
  }
}
