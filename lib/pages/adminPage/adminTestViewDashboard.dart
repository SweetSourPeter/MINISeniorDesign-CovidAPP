import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/models/user.dart';
import 'package:covidapp/pages/contants/contant.dart';
import 'package:covidapp/service/database.dart';
import 'package:covidapp/widgets/loading.dart';
import 'package:covidapp/widgets/qrCodeDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AdminTestReviewDashboard extends StatefulWidget {
  AdminTestReviewDashboard({Key key}) : super(key: key);

  @override
  _AdminTestReviewDashboardState createState() =>
      _AdminTestReviewDashboardState();
}

final databaseMehods = DatabaseMehods();

class _AdminTestReviewDashboardState extends State<AdminTestReviewDashboard> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    Stream<List<Map<String, dynamic>>> data = databaseMehods.getCovidTestReg();
    return Container(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: data == null
                ? Container()
                : Column(
                    children: [
                      StreamBuilder(
                        stream: data,
                        builder: (context, snapshot) {
                          print('snapshot data here');
                          print(snapshot.data);
                          if (snapshot.hasError)
                            return Center(
                              child: Text("Error"),
                            );
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Loading();
                            default:
                              return !snapshot.hasData
                                  ? Center(
                                      child: Text("Empty"),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: buildCard(
                                            context,
                                            snapshot.data[index]
                                                ['currentTemprature'],
                                            snapshot.data[index]['userID'],
                                            snapshot.data[index]
                                                ['appointmentTime'],
                                            snapshot.data[index]
                                                ['submitionTime'],
                                            snapshot.data[index]['covidTestID'],
                                            snapshot.data[index]['symptoms'],
                                            snapshot.data[index]['school'],
                                          ),
                                        );
                                      },
                                    );
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
          )),
    );
  }
}

Widget buildCard(
  BuildContext context,
  String currentTemprature,
  String userID,
  Timestamp appointmentTime,
  Timestamp submittedTime,
  String covidTestID,
  String symptoms,
  String school,
) {
  // var date = new DateTime.fromMillisecondsSinceEpoch(1000 * submittedTime);
  print(appointmentTime.toDate());
  print(covidTestID);
  return GestureDetector(
    onTap: () async {
      print('ontap');
      await showDialog(
          context: context,
          builder: (_) => Dialog(
                  child: Container(
                height: 480,
                child: Column(
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    AutoSizeText(
                      'UserID: ' + userID,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Temprature : ' + currentTemprature + '°C',
                      style: TextStyle(
                        color: double.parse(currentTemprature) < 37.2
                            ? Colors.black54
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'School : ' + school,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Submit time : ' +
                          submittedTime.toDate().toIso8601String(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Apointment time : ' +
                          appointmentTime.toDate().toIso8601String(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Symptom Description : ' + symptoms,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                    QrImage(
                      data: covidTestID,
                      version: QrVersions.auto,
                      size: 320,
                      gapless: false,
                    ),
                  ],
                ),
              )));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: <Widget>[
            AutoSizeText(
              appointmentTime.toDate().toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "UserID: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Appointment Time: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Temprature:  ",
                        style: TextStyle(
                          color: double.parse(currentTemprature) < 37.2
                              ? Colors.black54
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        userID.toString(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        appointmentTime.toDate().toIso8601String(),
                        style: TextStyle(
                          color: double.parse(currentTemprature) < 37.2
                              ? Colors.black54
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        currentTemprature + '°C',
                        style: TextStyle(
                          color: double.parse(currentTemprature) < 37.2
                              ? Colors.black54
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
