import 'package:covidapp/models/user.dart';
import 'package:covidapp/models/userCovidTestInfo.dart';
import 'package:covidapp/service/database.dart';
import 'package:covidapp/widgets/qrCodeDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CovidTestProvider with ChangeNotifier {
  final databaseMehods = DatabaseMehods();
  String _school;
  DateTime _submitionTime;
  DateTime _appointmentTime;
  String _symptoms;
  String _currentTemprature;
  String _userID;

  String _covidTestID;
  int _userNumbers;
  var uuid = Uuid(); // create a unique ID for this new covid test

  //getters not used yet
  String get school => _school;
  DateTime get submitionTime => _submitionTime;
  DateTime get appointmentTime => _appointmentTime;
  String get currentTemprature => _currentTemprature;
  String get covidTestID => _covidTestID;
  int get userNumbers => _userNumbers;
  String get symptoms => _symptoms;
  String get userID => _userID;

  //setters
  changeschool(String value) {
    _school = value;
    notifyListeners();
  }

  changecovidTestSubmitionTime(DateTime value) {
    _submitionTime = value;
    notifyListeners();
  }

  changecovidTestAppointmentTime(DateTime value) {
    _appointmentTime = value;
    notifyListeners();
  }

  changecovidTemp(String value) {
    _currentTemprature = value;
    notifyListeners();
  }

  changecovidTestID(String value) {
    _covidTestID = value;
    notifyListeners();
  }

  changeSymptoms(String value) {
    _symptoms = value;
    notifyListeners();
  }

  changeuserID(String value) {
    _userID = value;
    notifyListeners();
  }

  //save this covid test into firestore for both user and covid test collection
  saveNewcovidTest(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    // final userdata = Provider.of<UserData>(context, listen: false);
    // String covidTestId = user.school.toUpperCase() +
    //     '_' +
    //     school.toUpperCase() +
    //     '_' +
    //     appointmentTime.toUpperCase() +
    //     currentTemprature.toUpperCase() +
    //     userID.toUpperCase();
    //save to Users Document
    // String covidTestId = uuid.v4();
    // var newcovidTestToUser = CovidTestInfo(
    //   appointmentTime: appointmentTime,
    //   covidTestID: covidTestId,
    // );
    // databaseMehods.savecovidTestToUser(newcovidTestToUser, user.uid);
    //save to covidTests Document
    var newcovidTestTocovidTest = CovidTestInfo(
      school: school,
      appointmentTime: appointmentTime,
      submitionTime: submitionTime,
      symptoms: symptoms,
      currentTemprature: currentTemprature,
      userID: user.uid,
      covidTestID: covidTestID,
    );
    databaseMehods.savecovidTestToUser(newcovidTestTocovidTest, user.uid);
    databaseMehods.savecovidTestToCovidTest(newcovidTestTocovidTest);
    // var newUser = User(userID: userId, admin: true);
    //TODO
    // databaseMehods.addUserTocovidTest(covidTestId, user);
  }

//   removecovidTest(BuildContext context, String covidTestID) {
//     final user = Provider.of<User>(context, listen: false);
//     print(user.userID);
//     print(covidTestID);
//     databaseMehods.removecovidTestFromUser(covidTestID, user.userID);
//     databaseMehods.removeUserFromcovidTest(covidTestID, user.userID);
//   }

//   //add covid test to user
//   savecovidTestToUser(BuildContext context, String covidTestId) {
//     final user = Provider.of<User>(context, listen: false);
//     String userId = user.userID;

//     var newcovidTestToUser = covidTestInfo(
//       currentTemprature: currentTemprature.toUpperCase(),
//       covidTestID: covidTestId,
//     );
//     databaseMehods.savecovidTestToUser(newcovidTestToUser, userId);
//     // var newUser = User(userID: userId, admin: true);
//     databaseMehods.addUserTocovidTest(covidTestId, user);
//   }
// }
}
