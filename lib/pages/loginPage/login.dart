import 'package:covidapp/pages/contants/contant.dart';
import 'package:covidapp/service/authenticate_service.dart';
import 'package:covidapp/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:covidapp/service/textDecoration.dart';
import 'package:covidapp/service/auth.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  final Function toggleAuthenticateMode;
  Login({this.toggleAuthenticateMode});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthenticateService _authservice = AuthenticateService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: darkblack,
            appBar: AppBar(
              backgroundColor: lightBlack,
              centerTitle: true,
              elevation: 5.0,
              title: Text(
                'Covid App',
                style: TextStyle(color: whiteAndGray),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: whiteAndGray,
                  ),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(color: whiteAndGray),
                  ),
                  onPressed: () {
                    // switch from login page to register page
                    widget.toggleAuthenticateMode();
                  },
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) =>
                            val.length < 4 ? 'Enter a Longer Password!' : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 25.0),
                      // SignInButton(
                      //   Buttons.Email,
                      //   text: "Sign in with Email",
                      //   onPressed: ()
                      //   },
                      // ),
                      RaisedButton(
                        color: Colors.grey,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            dynamic result =
                                await _authservice.login(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Incorrect Email or Password';
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 45.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () {
                          authService.googleSignIn();
                        },
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: "Sign in with Facebook",
                        onPressed: () {
                          authService.googleSignIn();
                        },
                      ),
                    ],
                  ),
                )),
          );
  }
}
