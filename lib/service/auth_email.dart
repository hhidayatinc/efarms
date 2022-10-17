import 'package:final_project/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;


  static Future<SignInSignUpResult> createUser(
      {required String email, required String pass}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return SignInSignUpResult(user: result.user!, message: '');
    } catch (e) {
      return SignInSignUpResult(message: e.toString(), user: null!);
    }
  }

  static Future<SignInSignUpResult> signInWithEmail(
      {required String email, required String pass}) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return SignInSignUpResult(user: result.user!, message: '');
    } catch (e) {
      // ignore: null_check_always_fails
      return SignInSignUpResult(message: e.toString(), user: null!);
    }
  }

  void signOut() {
   _auth.signOut();
 }
}

// class AuthService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;


//   static Future<SignInSignUpResult> createUser(
//       {required String email, required String pass}) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: pass);
//       return SignInSignUpResult(user: result.user!, message: '');
//     } catch (e) {
//       // ignore: null_check_always_fails
//       return SignInSignUpResult(message: e.toString(), user: null!);
//     }
//   }

//   static Future<SignInSignUpResult> signInWithEmail(
//       {required String email, required String pass}) async {
//     try {
//       UserCredential result =
//           await _auth.signInWithEmailAndPassword(email: email, password: pass);
//       return SignInSignUpResult(user: result.user!, message: '');
//     } catch (e) {
//       // ignore: null_check_always_fails
//       return SignInSignUpResult(message: e.toString(), user: null!);
//     }
//   }

//   void signOut() {
//    _auth.signOut();
//  }
// }
