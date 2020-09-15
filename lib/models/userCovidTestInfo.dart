class CovidTestInfo {
  DateTime submitionTime;
  String school;
  DateTime appointmentTime;
  String symptoms;
  String currentTemprature;
  String userID;
  String covidTestID;

  CovidTestInfo({
    this.submitionTime,
    this.school,
    this.appointmentTime,
    this.symptoms,
    this.currentTemprature,
    this.userID,
    this.covidTestID,
  });

  Map<String, dynamic> toMapIntoUsers() {
    return {
      'school': school,
      'submitionTime': submitionTime,
      'college': appointmentTime,
      'symptoms': symptoms,
      'currentTemprature': currentTemprature,
      'userID': userID,
      'covidTestID': covidTestID,
    };
  }

  Map<String, dynamic> toMapIntoTestAppointment() {
    print('to map TestAppointment called');
    return {
      'school': school,
      'submitionTime': submitionTime,
      'college': appointmentTime,
      'symptoms': symptoms,
      'currentTemprature': currentTemprature,
      'userID': userID,
      'covidTestID': covidTestID,
    };
  }

  CovidTestInfo.fromFirestore(Map<String, dynamic> firestore)
      : school = firestore['school'],
        submitionTime = firestore['submitionTime'],
        appointmentTime = firestore['college'],
        symptoms = firestore['symptoms'],
        currentTemprature = firestore['currentTemprature'],
        userID = firestore['userID'],
        covidTestID = firestore['covidTestID'];
}
