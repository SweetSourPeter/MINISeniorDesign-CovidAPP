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

class AdminDashboard extends StatefulWidget {
  AdminDashboard({Key key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

final databaseMehods = DatabaseMehods();

class _AdminDashboardState extends State<AdminDashboard> {
  DateTime selectedDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    Stream<List<Map<String, dynamic>>> data =
        databaseMehods.getAdminDailyReport(selectedDateTime);
    return Container(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                FlatButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2020, 9, 1),
                          maxTime: DateTime.now(), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          selectedDateTime = date;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      selectedDateTime.year.toString() +
                          '/' +
                          selectedDateTime.month.toString() +
                          '/' +
                          selectedDateTime.day.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    )),
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
                                        snapshot.data[index]['temprature'],
                                        snapshot.data[index]['userID'],
                                        snapshot.data[index]['submitTime'],
                                        snapshot.data[index]['reportID']),
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
  String temprature,
  String userID,
  Timestamp submittedTime,
  String reportID,
) {
  // var date = new DateTime.fromMillisecondsSinceEpoch(1000 * submittedTime);
  print(submittedTime.toDate());
  print(reportID);
  return GestureDetector(
    onTap: () async {
      print('ontap');
      await showDialog(
          context: context,
          builder: (_) => QRImageDialog(
                qr_link: reportID,
              ));
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
              submittedTime.toDate().toString(),
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
                        "Temprature:  ",
                        style: TextStyle(
                          color: int.parse(temprature) < 37.2
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
                        temprature + '°C',
                        style: TextStyle(
                          color: int.parse(temprature) < 37.2
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
