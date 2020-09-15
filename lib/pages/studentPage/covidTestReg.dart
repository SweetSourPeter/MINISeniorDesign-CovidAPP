import 'package:covidapp/pages/contants/contant.dart';
import 'package:covidapp/providers/userTestProvider.dart';
import 'package:covidapp/widgets/qrCodeDialog.dart';
import 'package:covidapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_health/flutter_health.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CovidTestReg extends StatefulWidget {
  @override
  _CovidTestRegState createState() => _CovidTestRegState();
}

final formKey = GlobalKey<FormState>();

TextEditingController schoolTextEditingController = new TextEditingController();
TextEditingController temperatureTextEditingController =
    new TextEditingController();

class _CovidTestRegState extends State<CovidTestReg> {
  //health KIT
  var _healthKitOutput;
  var _hkDataList = List<HKHealthData>();
  var _gfDataList = List<GFHealthData>();
  var str = "";
  bool _isAuthorized = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    /*Future.delayed(Duration(seconds: 2), () async {
      _healthKitOutput = await FlutterHealth.checkIfHealthDataAvailable();
      setState(() {});
    });*/
    DateTime startDate = DateTime.utc(2020, 09, 15);
    DateTime endDate = DateTime.now();
    Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await FlutterHealth.requestAuthorization();
      if (_isAuthorized)
        _gfDataList
            .addAll(await FlutterHealth.getGFAllData(startDate, endDate));
      setState(() {});

      if (_isAuthorized)
        _hkDataList.addAll(
            await FlutterHealth.getHKBodyTemperature(startDate, endDate));
      setState(() {});
    });
    if (!mounted) return;
    print('temprature is ');
    print(_hkDataList);
  }

  var uuid = Uuid(); // create a unique ID for this new covid test

  var currentSelectedValueSymptom;
  var currentSelectedValueSchool;
  bool timeSelected = false;
  List<String> feeling = [
    'I just need this test for attending school',
    "I feel physical normal",
    "I feel tired",
    "I am having a fever",
    'This is emergency!!!',
  ];
  List<String> schools = [
    "Boston University",
    "Harvard University",
    "Massachusetts Institute of Technology",
    'University of Massachusetts',
  ];

  @override
  Widget build(BuildContext context) {
    //provider of the course
    final covidTestProvider = Provider.of<CovidTestProvider>(context);
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
        // centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        // title: Text("Create Course"),
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
                      'Register for a covid test',
                      textAlign: TextAlign.left,
                      style: largeTitleTextStyle(),
                    ),
                  ),
                ),
              ),
              Text('Create your covid test'),
              //College
              SizedBox(
                height: 30,
              ),
              DropdownButtonFormField<String>(
                decoration: buildInputDecorationPinky(
                  true,
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  'Select Symptom',
                  20,
                  7,
                ),
                // hint: Text("Select Term"),
                value: currentSelectedValueSymptom,
                isExpanded: true,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValueSymptom = newValue;
                  });
                  print(currentSelectedValueSymptom);
                  covidTestProvider.changeSymptoms(newValue);
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
                height: 15,
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
                  covidTestProvider.changeschool(newValue);
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
                height: 15,
              ),
              //temprature
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
                  // setState(() {
                  //   temperatureTextEditingController.text = newValue;
                  // });
                  print(newValue);
                  covidTestProvider.changecovidTemp(newValue);
                },
                // InputDecoration(
                //   hintText: 'Department, ex:CS',
                // ),
                validator: (val) {
                  return val.length > 1
                      ? null
                      : "Please Enter a correct temprature";
                },
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2021, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      setState(() {
                        timeSelected = true;
                      });
                      covidTestProvider.changecovidTestAppointmentTime(date);
                      covidTestProvider
                          .changecovidTestSubmitionTime(DateTime.now());
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    !timeSelected
                        ? 'pick avilable Appointment time'
                        : 'time picked',
                    style: TextStyle(
                        fontSize: 16,
                        color: timeSelected ? Colors.blue : Colors.red),
                  )),
              //Course Name

              SizedBox(
                height: 40,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: whiteAndGray,
                child: Text('Save'),
                onPressed: () async {
                  //TODO create class in database
                  String covidTestId = uuid.v4();
                  covidTestProvider.changecovidTestID(covidTestId);
                  if (formKey.currentState.validate()) {
                    covidTestProvider.saveNewcovidTest(context);

                    await showDialog(
                        context: context,
                        builder: (_) => QRImageDialog(
                              qr_link: '11111',
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
