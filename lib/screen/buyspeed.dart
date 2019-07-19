import 'package:flutter/material.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';

class BuyspeedPage extends StatefulWidget {
    const BuyspeedPage({Key key}) : super(key: key);
  @override
  State createState() => _BuySpeedState();
}

class _BuySpeedState extends State<BuyspeedPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Text('台北'),
                    ImageFactory.more
                  ],
                )
              )
            ],
          )
        ],
      ),
    );
  }
}