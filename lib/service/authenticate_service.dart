import 'package:covidapp/service/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidapp/models/user.dart';

class AuthenticateService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _createUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_createUser);
  }

  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _createUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      try {
        await DatabaseService(uid: user.uid)
            .updateUserData('Hanming', 'Hanming\'s email', true);
      } catch (e) {
        print('Look at here: ');
        print(e.toString());
      }

      return _createUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
