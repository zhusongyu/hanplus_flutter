import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'package:hanplus_flutter/shared/palette.dart';

class ShopcartPage extends StatefulWidget {
  const ShopcartPage({Key key}) : super(key: key);
  @override
  State createState() => _ShopcartState();
}

class _ShopcartState extends State<ShopcartPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
        // actions: <Widget>[
        //   GestureDetector(
        //       onTap: () {},
        //       child: Padding(
        //         padding: EdgeInsets.only(right: 20),
        //         child: Row(
        //           children: <Widget>[
        //             Text(
        //               '编辑',
        //               style: TextStyle(color: Palette.tealBlue, fontSize: 17),
        //             ),
        //           ],
        //         ),
        //       ))
        // ],
      ),
      body: _buildItem(),
    );
  }

  Widget _buildItem() {
    return Text(
      'data',
      style: TextStyle(color: Colors.black),
    );
  }
}
