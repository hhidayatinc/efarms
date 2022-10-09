import 'package:firebase_auth/firebase_auth.dart';

class SignInSignUpResult {
   late User user;
   late String message;
  SignInSignUpResult({required this.user, required this.message});
}