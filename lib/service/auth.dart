import 'package:firebase_auth/firebase_auth.dart';

class SignInSignUpResult {
    User user;
    String message;
  SignInSignUpResult({required this.user, required this.message});
}