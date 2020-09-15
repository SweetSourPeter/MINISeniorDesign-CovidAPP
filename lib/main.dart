import 'package:covidapp/mainMenu.dart';
import 'package:covidapp/models/userCovidTestInfo.dart';
import 'package:covidapp/providers/userTestProvider.dart';
import 'package:covidapp/service/authenticate.dart';
import 'package:covidapp/service/authenticate_service.dart';
import 'package:covidapp/service/wrapper.dart';
import 'package:covidapp/pages/loginPage/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
            create: (context) => AuthenticateService().user), //Login user
        ChangeNotifierProvider(
            create: (context) => CovidTestProvider()), //course Provider
      ],
      child: MaterialApp(
        title: 'Covid Demo',
        // home: Wrapper()
        home: Wrapper(),
      ),
    );
  }
}
