import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection ref
  final CollectionReference collection = Firestore.instance.collection('users');
  Future updateUserData(String name, String email, bool admin) async {
    return await collection
        .document(uid)
        .setData({'name': name, 'email': email, 'admin': admin});
  }
}
