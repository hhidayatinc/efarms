// ignore_for_file: null_check_always_fails

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String?> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHODJ
  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await _auth.signOut();

    print('signout');
  }
}

// import 'package:final_project/service/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class AuthService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;


//   static Future<SignInSignUpResult> createUser(
//       {required String email, required String pass}) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: pass);
//       return SignInSignUpResult(user: result.user!, message: '');
//     } catch (e) {
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
