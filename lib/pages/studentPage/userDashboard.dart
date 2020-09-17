import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/models/user.dart';
import 'package:covidapp/service/database.dart';
import 'package:covidapp/widgets/loading.dart';
import 'package:covidapp/widgets/qrCodeDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({Key key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

final databaseMehods = DatabaseMehods();

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Stream<List<Map<String, dynamic>>> data =
        databaseMehods.getUserDailyReport(user.uid);
    return Container(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: StreamBuilder(
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
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: buildCard(
                                  context,
                                  snapshot.data[index]['temprature'],
                                  snapshot.data[index]['feeling'],
                                  snapshot.data[index]['submitTime'],
                                  snapshot.data[index]['reportID']),
                            );
                          },
                        );
              }
            },
          )),
    );
  }
}

Widget buildCard(
  BuildContext context,
  String temprature,
  String feeling,
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
                        "Temprature:  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Feeling: ",
                        style: TextStyle(
                          color: Colors.black,
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
                        temprature + '°C',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        feeling.toString(),
                        style: TextStyle(
                          color: Colors.black54,
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
