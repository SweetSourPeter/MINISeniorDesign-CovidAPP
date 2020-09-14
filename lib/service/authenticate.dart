import 'package:covidapp/widgets/login.dart';
import 'package:covidapp/widgets/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool needSignIn = true;
  void toggleAuthenticateMode() {
    setState(() {
      needSignIn = !needSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (needSignIn) {
      return Login(toggleAuthenticateMode: toggleAuthenticateMode);
    } else {
      return Register(toggleAuthenticateMode: toggleAuthenticateMode);
    }
  }
}
