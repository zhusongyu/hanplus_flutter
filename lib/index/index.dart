import 'package:flutter/material.dart';
import 'navigation_icon_view.dart';
import '../screen/entry.dart';
import '../screen/home.dart';
import '../screen/buyspeed.dart';
import '../screen/shopCart.dart';
import '../screen/mine.dart';
import '../shared/image_factory.dart';
import '../shared/palette.dart';
import 'package:hanplus_flutter/routes/routes.dart';

// import '../global_config.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: ImageFactory.tabHome,
        title: new Text("首页"),
        activeIcon: ImageFactory.tabHomeSel,
        vsync: this,
      ),
      new NavigationIconView(
        icon: ImageFactory.tabBuySpeed,
        title: new Text("极速购"),
        activeIcon: ImageFactory.tabBuySpeedSel,
        vsync: this,
      ),
      new NavigationIconView(
        icon: ImageFactory.tabShopCart,
        title: new Text("购物车"),
        activeIcon: ImageFactory.tabShopCartSel,
        vsync: this,
      ),
      new NavigationIconView(
        icon: ImageFactory.tabMine,
        title: new Text("个人中心"),
        activeIcon: ImageFactory.tabMineSel,
        vsync: this,
      ),
    ];
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _pageList = <StatefulWidget>[
      new HomePage(),
      new BuyspeedPage(),
      new ShopcartPage(),
      new MinePage(),
    ];
    _currentPage = _pageList[_currentIndex];
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationIconView) =>
                navigationIconView.item)
            .toList(),
        currentIndex: _currentIndex,
        fixedColor: Palette.tealBlue,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
            _currentPage = _pageList[_currentIndex];
          });
        });

    return new MaterialApp(
      home: new Scaffold(
        body: new Center(child: _currentPage),
        bottomNavigationBar: bottomNavigationBar,
        
      ),
      // theme: GlobalConfig.themeData
    );
  }
}
