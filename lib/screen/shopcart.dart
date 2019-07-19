import 'package:flutter/material.dart';
import 'package:hanplus_flutter/shared/image_factory.dart';

class ShopcartPage extends StatefulWidget {
    const ShopcartPage({Key key}) : super(key: key);
  @override
  State createState() => _ShopcartState();
}

class _ShopcartState extends State<ShopcartPage> {
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