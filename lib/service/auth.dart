import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

// this file is for google sign in only

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService() {
    user = Observable(_auth.onAuthStateChanged);
    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    updateUserData(user);
    print("Signed In with user: " + user.displayName);
    loading.add(false);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'name': user.displayName,
      'lastSenn': DateTime.now(),
      'admin': false,
    }, merge: true);
  }

  void signOut() {
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
