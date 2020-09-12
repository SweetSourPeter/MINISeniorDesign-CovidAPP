import 'package:covidapp/mainMenu.dart';
import 'package:covidapp/pages/studentPage/covidTestReg.dart';
import 'package:covidapp/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // AuthMethods authMethods = new AuthMethods();
    print('wrapper called');
    String userID = '11111';

    // return either the Home or Authenticate widget\
    // if (user == null) {
    //   return SignIn();
    // } else {
    return MultiProvider(
      providers: [
        // StreamProvider(
        //     create: (context) => DatabaseMehods()
        //         .userDetails(user.userID)), //Login user data details
        // authMethods.isUserLogged().then((value) => null);
        // StreamProvider(
        //     create: (context) =>
        //         DatabaseMehods().getMyCovidTest(userID)), // get all course
        // StreamProvider(
        //     create: (context) => UserDatabaseService()
        //         .getMyContacts(user.userID)), // get all contacts
      ],
      child: MainMenu(),
    );
    // }
  }
}
