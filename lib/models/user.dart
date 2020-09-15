class User {
  final String uid;
  final bool admin;

  User({this.uid, this.admin});
}

class UserData {
  final String uid;
  final String email;
  final bool admin;
  final String userName;

  UserData({this.uid, this.admin, this.email, this.userName});
  //get the data for current user
  UserData.fromFirestore(Map<String, dynamic> firestore, this.uid)
      : admin = firestore['admin'],
        email = firestore['email'],
        userName = firestore['name'];
}
