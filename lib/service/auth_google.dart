import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? email;
String? imageUrl;
String? uid;

Future<String?> signInWithGoogle() async {
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

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}


// import 'package:final_project/pages/home_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:google_sign_in/google_sign_in.dart';

// class Authentication {
//   static SnackBar customSnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content,
//         style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }

//   static Future<FirebaseApp> initializeFirebase({
//     required BuildContext context,
//   }) async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();

//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => const HomePage()
//         ),
//       );
//     }

//     return firebaseApp;
//   }

//   static Future<User?> signInWithGoogle({required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     if (kIsWeb) {
//       GoogleAuthProvider authProvider = GoogleAuthProvider();

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithPopup(authProvider);

//         user = userCredential.user;
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       final GoogleSignIn googleSignIn = GoogleSignIn();

//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();

//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );

//         try {
//           final UserCredential userCredential =
//               await auth.signInWithCredential(credential);

//           user = userCredential.user;
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'account-exists-with-different-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               Authentication.customSnackBar(
//                 content:
//                     'The account already exists with a different credential',
//               ),
//             );
//           } else if (e.code == 'invalid-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               Authentication.customSnackBar(
//                 content:
//                     'Error occurred while accessing credentials. Try again.',
//               ),
//             );
//           }
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.customSnackBar(
//               content: 'Error occurred using Google Sign In. Try again.',
//             ),
//           );
//         }
//       }
//     }

//     return user;
//   }

//  static Future<void> signOutGoogle() async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   await googleSignIn.signOut();
//   print("User Signed Out");
// }

// }