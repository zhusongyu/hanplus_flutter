import 'package:flutter/material.dart';
import 'package:hanplus_flutter/shared/palette.dart';

class HPTextField extends StatefulWidget {
  final String hitText;
  final TextEditingController textEditingController;

  const HPTextField({Key key, this.hitText, this.textEditingController}) : super(key: key);
  @override
  State createState() => _HPTextFieldState();
}

class _HPTextFieldState extends State<HPTextField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
          color: Colors.white30,
          alignment: Alignment.center,
          height: 48,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              // expands: true,
              style: TextStyle(color: Colors.white, fontSize: 14),
              controller: widget.textEditingController,
              decoration: InputDecoration(
                hintText: widget.hitText,
                hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
              ),
            ),
          )),
    );
  }
}
