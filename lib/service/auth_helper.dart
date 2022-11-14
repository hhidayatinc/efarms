//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:package_info/package_info.dart';

class AuthHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
 static final GoogleSignIn googleSignIn = GoogleSignIn();
  static String? name;
static String? email;
static String? imageUrl;
static String? uid;

  static signInWithEmail({required String email, required String password}) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final User? user = res.user;
    return user;
  }

  static signupWithEmail({required String email, required String password}) async {
    final res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User? user = res.user;
    return user;
  }

  static signInWithGoogle() async {
    await Firebase.initializeApp();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User? user = authResult.user;
  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    uid = user.uid;
    // Only taking the first part of the name, i.e., First Name
    if (name!.contains(" ")) {
      name = name!.substring(0, name!.indexOf(" "));
    }

    assert(!user.isAnonymous);
    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser!.uid);

    print('signInWithGoogle succeeded: $user');
    return '$user';
  }
  return null;
  }

  static logOut() {
    GoogleSignIn().signOut();
    return _auth.signOut();
  }
}