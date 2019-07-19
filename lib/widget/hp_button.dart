import 'package:flutter/material.dart';
import 'package:hanplus_flutter/shared/palette.dart';

class HPButton extends StatefulWidget {
  final String buttonTitle;
  final VoidCallback onTap;

  const HPButton({Key key, this.buttonTitle, this.onTap}) : super(key: key);
  @override
  State createState() => _HPButtonState();
}

class _HPButtonState extends State<HPButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          height: 48,
          child: Text(widget.buttonTitle,
              style: TextStyle(
                  color: Palette.tealBlue, fontSize: 17, inherit: false)),
        ),
      ),
    );
  }
}
