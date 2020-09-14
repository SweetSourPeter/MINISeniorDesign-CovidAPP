import 'package:covidapp/mainMenu.dart';
import 'package:covidapp/service/authenticate.dart';
import 'package:covidapp/service/wrapper.dart';
import 'package:covidapp/pages/loginPage/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Demo',
      // home: Wrapper()
      home: Authenticate(),
    );
  }
}
