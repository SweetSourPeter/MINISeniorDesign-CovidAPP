import 'package:covidapp/pages/contants/contant.dart';
import 'package:flutter/material.dart';

InputDecoration buildInputDecorationPinky(
    bool isIcon, Icon prefixIcon, String hintText, double boarderRadius) {
  return InputDecoration(
    prefixIcon: isIcon ? prefixIcon : null,
    fillColor: whiteAndGray,
    filled: true,
    // prefixIcon: Icon(Icons.search, color: Colors.grey),
    hintText: hintText,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(boarderRadius),
      // borderSide: BorderSide.none
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(boarderRadius),
      // borderSide: BorderSide.none
    ),

    contentPadding: EdgeInsets.all(10),
    hintStyle: TextStyle(color: Colors.grey), // KEY PROP
  );
}

TextStyle largeTitleTextStyle() {
  return TextStyle(
      color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700);
}
