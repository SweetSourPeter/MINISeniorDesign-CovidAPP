import 'package:flutter/material.dart';

// Colos that use in our app
const blueAndGreen = Color(0xFF32e0c4);
const whiteAndGray = Color(0xFFEEEEEE);
const lightBlack = Color(0xFF393e46);
const darkblack = Color(0xFF222831);

const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 4),
  blurRadius: 4,
  color: Colors.black26,
);
LinearGradient kGradientShimmer = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Colors.grey[300],
    Colors.grey[100],
  ],
);

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]}.';
//Color for covid cases
Color kPrimaryColor = Color(0xFF166DE0);
Color kConfirmedColor = Color(0xFFFF1242);
Color kActiveColor = Color(0xFF017BFF);
Color kRecoveredColor = Color(0xFF29A746);
Color kDeathColor = Color(0xFF6D757D);
