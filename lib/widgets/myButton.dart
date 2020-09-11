import 'package:covidapp/pages/contants/contant.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double textSize;
  final double height;
  final GestureTapCallback onTap;

  MyButton({this.text, this.iconData, this.textSize, this.height, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            color: whiteAndGray,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: whiteAndGray, fontSize: textSize),
          ),
        ],
      ),
      onPressed: () {
        onTap();
      },
    );
  }
}
