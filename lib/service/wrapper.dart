import 'package:covidapp/mainMenu.dart';
import 'package:covidapp/models/user.dart';
import 'package:covidapp/pages/studentPage/covidTestReg.dart';
import 'package:covidapp/service/authenticate.dart';
import 'package:covidapp/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // AuthMethods authMethods = new AuthMethods();
    print('wrapper called');

    // return either the Home or Authenticate widget\
    // if (user == null) {
    //   return SignIn();
    // } else {
    // print(user.uid);
    if (user == null) {
      return Authenticate();
    } else {
      return MultiProvider(providers: [
        StreamProvider(
            create: (context) => DatabaseMehods()
                .userDetails(user.uid)), //Login user data details
        StreamProvider(
            create: (context) => DatabaseMehods()
                .getMyCovidTest(user.uid)), //Login user data details
        StreamProvider(
            create: (context) => DatabaseMehods()
                .getUserDailyReport(user.uid)), //get user reports detais
      ], child: MainMenu());
    }
  }
}
