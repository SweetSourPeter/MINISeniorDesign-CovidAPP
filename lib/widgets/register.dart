import 'package:flutter/material.dart';
import 'package:covidapp/service/authenticate_service.dart';
import 'package:covidapp/service/textDecoration.dart';
import 'loading.dart';

class Register extends StatefulWidget {
  final Function toggleAuthenticateMode;
  Register({this.toggleAuthenticateMode});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: Text('Register to Covidappv2'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    // switch page
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
                        validator: (val) =>
                            val.length < 6 ? 'Enter a Longer Password' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
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
                                await _authservice.register(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please Supply a Valid Email';
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                )),
          );
  }
}
