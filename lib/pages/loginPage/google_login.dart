import 'package:flutter/material.dart';
import 'package:covidapp/service/auth.dart';

// this file is USELESS

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialButton(
            color: Colors.red[200],
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              authService.signOut();
            },
          );
        } else {
          return MaterialButton(
            color: Colors.yellow[300],
            child: Text(
              'Google Sign In',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              authService.googleSignIn();
            },
          );
        }
      },
    );
  }
}
