import 'package:covidapp/models/user.dart';
import 'package:covidapp/pages/contants/contant.dart';
import 'package:covidapp/pages/studentPage/covidTestReg.dart';
import 'package:covidapp/providers/userTestProvider.dart';
import 'package:covidapp/service/database.dart';
import 'package:covidapp/widgets/qrCodeDialog.dart';
import 'package:covidapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

final formKey = GlobalKey<FormState>();
TextEditingController temperatureTextEditingController =
    new TextEditingController();
TextEditingController locationTextEditingController =
    new TextEditingController();

var currentSelectedValueSchool;
List<String> feeling = [
  'Good and strong',
  "I feel physical normal",
  "I feel tired",
  "I am having a fever",
  'I need a test',
];
var beenToCrowdPlace;
var beenToWheer = '';
List<String> yesNo = ['YES', 'NO'];
List<String> schools = [
  "Boston University",
  "Harvard University",
  "Massachusetts Institute of Technology",
  'University of Massachusetts',
];
var currentSelectedValueSymptom;

class UserDailyReport extends StatefulWidget {
  const UserDailyReport({Key key}) : super(key: key);

  @override
  _UserDailyReportState createState() => _UserDailyReportState();
}

class _UserDailyReportState extends State<UserDailyReport> {
  bool beenToCrowdPlaceBool = false;
  final databaseMehods = DatabaseMehods();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final covidTestInfo = Provider.of<CovidTestProvider>(context);
    var uuid = Uuid(); // create a unique ID for this new covid test
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(left: kDefaultPadding),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: ListView(
            children: <Widget>[
              //Hint Text
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 0, top: 0, bottom: 0),
                  child: Container(
                    // color: orengeColor,
                    child: Text(
                      'Your daily reports',
                      textAlign: TextAlign.left,
                      style: largeTitleTextStyle(),
                    ),
                  ),
                ),
              ),
              Text('How are you today?'),
              //College
              SizedBox(
                height: 30,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: buildInputDecorationPinky(
                  true,
                  Icon(
                    Icons.school,
                    color: Colors.black,
                  ),
                  'Select School',
                  20,
                  7,
                ),
                // hint: Text("Select Term"),
                value: currentSelectedValueSchool,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValueSchool = newValue;
                  });
                  print(currentSelectedValueSchool);
                },
                validator: (String val) {
                  return (val == null) ? "Please select the school" : null;
                },
                items: schools.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toUpperCase(),
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 14,
              ),
              DropdownButtonFormField<String>(
                decoration: buildInputDecorationPinky(
                  true,
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  'How do you feel right now',
                  20,
                  7,
                ),
                // hint: Text("Select Term"),
                value: currentSelectedValueSymptom,
                isExpanded: true,
                isDense: true,
                onChanged: (newValue) {
                  if (newValue == feeling[4].toUpperCase()) {
                    print('need a test revoked');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiProvider(providers: [
                                ChangeNotifierProvider<CovidTestProvider>.value(
                                  value: covidTestInfo,
                                ),
                              ], child: CovidTestReg())),
                    );
                  } else {
                    setState(() {
                      currentSelectedValueSymptom = newValue;
                    });
                    // print(currentSelectedValueSymptom);
                  }
                },
                validator: (String val) {
                  return (val == null) ? "Please select the symptom" : null;
                },
                items: feeling.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toUpperCase(),
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 14,
              ),
              DropdownButtonFormField<String>(
                decoration: buildInputDecorationPinky(
                  true,
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  'Have you been to Crowd place today?',
                  20,
                  7,
                ),
                // hint: Text("Select Term"),
                value: beenToCrowdPlace,
                isExpanded: true,
                isDense: true,
                onChanged: (newValue) {
                  if (newValue == 'YES') {
                    setState(() {
                      beenToCrowdPlaceBool = true;
                    });
                  } else {
                    setState(() {
                      beenToCrowdPlaceBool = false;
                    });
                  }
                  // print(currentSelectedValueSymptom);
                },
                validator: (String val) {
                  return (val == null)
                      ? "Please don\'t leave this empty"
                      : null;
                },
                items: yesNo.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toUpperCase(),
                    child: Text(value),
                  );
                }).toList(),
              ),

              SizedBox(
                height: 10,
              ),
              beenToCrowdPlaceBool
                  ? TextFormField(
                      controller: locationTextEditingController,
                      decoration: buildInputDecorationPinky(
                        false,
                        Icon(
                          Icons.timelapse,
                          color: Colors.black,
                        ),
                        'Where have you been?',
                        20,
                        20,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          beenToWheer = newValue;
                        });
                        print(newValue);
                      },
                      validator: (val) {
                        return val.length > 1
                            ? null
                            : "Please Enter a location";
                      },
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: temperatureTextEditingController,
                decoration: buildInputDecorationPinky(
                  false,
                  Icon(
                    Icons.timelapse,
                    color: Colors.black,
                  ),
                  'Current Temprature °C',
                  20,
                  20,
                ),
                onChanged: (newValue) {
                  print(newValue);
                },
                validator: (val) {
                  return val.length > 1
                      ? null
                      : "Please Enter a correct temprature";
                },
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: whiteAndGray,
                child: Text('Submit'),
                onPressed: () async {
                  //TODO create class in database
                  String reportID = uuid.v4();
                  if (formKey.currentState.validate()) {
                    databaseMehods.saveUserDailyReport2Reports(
                        user.uid,
                        DateTime.now(),
                        currentSelectedValueSchool,
                        currentSelectedValueSymptom,
                        beenToWheer,
                        temperatureTextEditingController.text,
                        reportID);
                    databaseMehods.saveUserDailyReport2User(
                        user.uid,
                        DateTime.now(),
                        currentSelectedValueSchool,
                        currentSelectedValueSymptom,
                        beenToWheer,
                        temperatureTextEditingController.text,
                        reportID);
                    await showDialog(
                        context: context,
                        builder: (_) => QRImageDialog(
                              qr_link: reportID,
                            ));
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
