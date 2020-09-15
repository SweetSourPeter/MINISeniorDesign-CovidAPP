import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/models/user.dart';
import 'package:covidapp/models/userCovidTestInfo.dart';

class DatabaseMehods {
  Future<void> savecovidTestToUser(CovidTestInfo covidTest, String userID) {
    print('savecovidTestToUser');
    print('$userID');
    //First update in the user level
    return Firestore.instance
        .collection('users')
        .document(userID)
        .collection('covidTests')
        .document(covidTest.covidTestID)
        .setData(covidTest.toMapIntoUsers())
        .catchError((e) {
      print(e.toString());
    });
    //also update in the covidTest level
  }

  Future<void> savecovidTestToCovidTest(CovidTestInfo covidTest) {
    print('savecovidTestTocovidTest');
    //First update in the user level
    return Firestore.instance
        .collection('covidTests')
        .document(covidTest.covidTestID)
        .setData(covidTest.toMapIntoTestAppointment(), merge: true)
        .catchError((e) {
      print(e.toString());
    });
    //also update in the covidTest level
  }
// Future<void> addUserToCovidTest(String covidTestsID, String user) {
// //First update in the user level
// print('add user to CovidTest called');
// return Firestore.instance
//     .collection('covidTests')
//     .document(covidTestsID)
//     .collection('users')
//     .document(user.userID)
//     .setData(user.toJson(), merge: true)
//     .catchError((e) {
//   print(e.toString());
// });
//also update in the covidTest level

// }

  Stream<List<CovidTestInfo>> getMyCovidTest(String userID) {
    print('gettre covide test info stream called');
    return Firestore.instance
        .collection('users')
        .document(userID)
        .collection('covidTests')
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => CovidTestInfo.fromFirestore(document.data))
            .toList());
  }

  Stream<UserData> userDetails(String userID) {
    print('called userdetails stream');
    return Firestore.instance
        .collection('users')
        .document(userID)
        .snapshots()
        .map((snapshot) => UserData.fromFirestore(snapshot.data, userID));
  }

  Future<void> saveUserDailyReport2Reports(
      String userID,
      DateTime submitTime,
      String school,
      String feeling,
      String location,
      String temprature,
      String reportID) {
    print('save Daily Reports to user');
    //First update in the user level
    return Firestore.instance
        .collection('dailyReport')
        .document(submitTime.year.toString() +
            submitTime.month.toString() +
            submitTime.day.toString())
        .collection('userDailyReports')
        .document(reportID)
        .setData({
      'userID': userID,
      'submitTime': submitTime,
      'school': school,
      'feeling': feeling,
      'location': location,
      'temprature': temprature,
      'reportID': reportID,
    }).catchError((e) {
      print(e.toString());
    });
    //also update in the covidTest level
  }

  Future<void> saveUserDailyReport2User(
      String userID,
      DateTime submitTime,
      String school,
      String feeling,
      String location,
      String temprature,
      String reportID) {
    print('save Daily Reports to user');
    //First update in the user level
    return Firestore.instance
        .collection('users')
        .document(userID)
        .collection('userDailyReports')
        .document(reportID)
        .setData({
      'userID': userID,
      'submitTime': submitTime,
      'school': school,
      'feeling': feeling,
      'location': location,
      'temprature': temprature,
      'reportID': reportID,
    }).catchError((e) {
      print(e.toString());
    });
    //also update in the covidTest level
  }
}
