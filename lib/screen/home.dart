import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';
import 'dart:ui';

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
  List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
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
                Column(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
                    )
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
                Container(
                    height: 300,
                    width: 300,
                    child: Wrap(
                      spacing: 20,
                      children: <Widget>[
                        _buildClassify(3, 'quanbu'),
                        _buildClassify(2, 'quanbu'),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildClassify(int index, String title) {
    return ClipRRect(
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
                  title,
                  style: TextStyle(
                      color:
                          selectIndex == index ? Colors.white : Palette.black30,
                      fontSize: 13),
                )
              ],
            ),
          ),
        ));
  }
}

// class Classify extends StatefulWidget {
//   const Classify(Key key, this.index, this.title) : super(key: key);
//   final int index;
//   final String title;
//   // final Key key;

//   @override
//   State createState() => _ClassifyState();

// }

// class _ClassifyState extends State<Classify> {

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(3)),
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               selectIndex = widget.index;
//             });
//           },
//           child: Container(
//             width: 75,
//             height: 32,
//             color: Palette.veryLightPink,
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 selectIndex == widget.index
//                     ? ImageFactory.allClassify
//                     : Text(""),
//                 Text(
//                   widget.title,
//                   style: TextStyle(
//                       color: selectIndex == widget.index
//                           ? Colors.white
//                           : Palette.black30,
//                       fontSize: 13),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class TestFlowDelegate extends FlowDelegate {
//   EdgeInsets margin = EdgeInsets.zero;

//   TestFlowDelegate({this.margin});
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     var x = margin.left;
//     var y = margin.top;
//     for (int i = 0; i < context.childCount; i++) {
//       var w = context.getChildSize(i).width + x + margin.right;
//       if (w < context.size.width) {
//         context.paintChild(i,
//             transform: new Matrix4.translationValues(x, y, 0.0));
//         x = w + margin.left;
//       } else {
//         x = margin.left;
//         y += context.getChildSize(i).height + margin.top + margin.bottom;
//         context.paintChild(i,
//             transform: new Matrix4.translationValues(x, y, 0.0));
//         x += context.getChildSize(i).width + margin.left + margin.right;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(FlowDelegate oldDelegate) {
//     return oldDelegate != this;
//   }
// }
