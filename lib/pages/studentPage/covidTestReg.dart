import 'package:covidapp/pages/contants/contant.dart';
import 'package:covidapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class covidTestReg extends StatefulWidget {
  @override
  _covidTestRegState createState() => _covidTestRegState();
}

final formKey = GlobalKey<FormState>();

TextEditingController collegeTextEditingController =
    new TextEditingController();
TextEditingController departmentTextEditingController =
    new TextEditingController();
TextEditingController courseNameTextEditingController =
    new TextEditingController();
TextEditingController sectionTextEditingController =
    new TextEditingController();

class _covidTestRegState extends State<covidTestReg> {
  var currentSelectedValue;
  List<String> feeling = [
    "I feel physical normal",
    "I feel tired",
    "I am haveing a fever",
  ];

  @override
  Widget build(BuildContext context) {
    //provider of the course
    // final covidTestInfo = Provider.of<CovidTestProvider>(context);
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
                  'Select symptom',
                  20,
                ),
                // hint: Text("Select Term"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                  print(currentSelectedValue);
                  // covidTestInfo.changesymptoms(currentSelectedValue);
                },
                validator: (String val) {
                  return (val == null) ? "Please select the term" : null;
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
              TextFormField(
                // onChanged: (value) => covidTestInfo.changeCourseCollege(value),
                controller: collegeTextEditingController,
                decoration: buildInputDecorationPinky(
                  false,
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  'College, ex:CAS',
                  20,
                ),
                // InputDecoration(hintText: 'College, ex:CAS'),
                validator: (val) {
                  return val.length > 1
                      ? null
                      : "Please Enter a correct College";
                },
              ),
              SizedBox(
                height: 15,
              ),
              //Department
              TextFormField(
                // onChanged: (value) =>
                // covidTestInfo.changeCourseDepartment(value),
                controller: departmentTextEditingController,
                decoration: buildInputDecorationPinky(
                  false,
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  'Department, ex:CS',
                  20,
                ),
                // InputDecoration(
                //   hintText: 'Department, ex:CS',
                // ),
                validator: (val) {
                  return val.length > 1
                      ? null
                      : "Please Enter a correct Department";
                },
              ),
              SizedBox(
                height: 15,
              ),
              //Course Name
              TextFormField(
                // onChanged: (value) => covidTestInfo.changeCourseName(value),
                controller: courseNameTextEditingController,
                decoration: buildInputDecorationPinky(
                  false,
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  'CourseName, ex:CS111',
                  20,
                ),
                // InputDecoration(hintText: 'CourseName, ex:CS111'),
                validator: (val) {
                  return val.length > 3
                      ? null
                      : "Please Enter a correct Course Name";
                },
              ),
              SizedBox(
                height: 15,
              ),
              //Section
              TextFormField(
                // onChanged: (value) => covidTestInfo.changeCourseSection(value),
                controller: sectionTextEditingController,
                decoration: buildInputDecorationPinky(
                  false,
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  'Section, ex:A1',
                  20,
                ),
                // InputDecoration(hintText: 'Section, ex:A1'),
                validator: (val) {
                  return val.length > 1
                      ? null
                      : "Please Enter a correct Section";
                },
              ),
              SizedBox(
                height: 40,
              ),
              // RaisedGradientButton(
              //   width: 100,
              //   height: 40,
              //   gradient: LinearGradient(
              //     colors: <Color>[Colors.red, orengeColor],
              //   ),
              //   onPressed: () {
              //     //TODO create class in database
              //     if (formKey.currentState.validate()) {
              //       CovidTestProvider.saveNewCourse(context);
              //       Navigator.pop(context);
              //     }
              //   },
              //   //之后需要根据friendsProvider改这部分display
              //   //TODO
              //   child: Text(
              //     'Create',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: whiteAndGray,
                child: Text('Save'),
                onPressed: () {
                  //TODO create class in database
                  if (formKey.currentState.validate()) {
                    // covidTestInfo.saveNewcovidTest(context);
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
