import 'package:flutter/material.dart';
import 'package:covidapp/service/auth.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
          return SignInButton(
            Buttons.Google,
            text: "Sign in with Google",
            onPressed: () {
              authService.googleSignIn();
            },
          );

          // MaterialButton(
          //   color: Colors.yellow[300],
          //   child: Text(
          //     'Google Sign In',
          //     style: TextStyle(color: Colors.blue),
          //   ),
          //   onPressed: () {
          //     authService.googleSignIn();
          //   },
          // );
        }
      },
    );
  }
}
