import 'package:flutter/material.dart';
//import 'authenticate_service.dart';

class Home extends StatelessWidget {
  //final AuthenticateService _authservice = AuthenticateService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Covidapp Version 2 Home Screen'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              //await _authservice.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('Quit'),
          )
        ],
      ),
    );
  }
}
