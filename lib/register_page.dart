import 'package:final_project/database/inventory.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/database/qc.dart';
import 'package:final_project/database/user.dart';
import 'package:final_project/login_page.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:final_project/service/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _isHidePass = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  void _togglePasswordvisibility() {
    setState(() {
      _isHidePass = !_isHidePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Container(
              child: Center(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 130, bottom: 50),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Righteous',
                            color: Color(0xFF4CAF50)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.email),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Enter an Email Address';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          email = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passController,
                        obscureText: _isHidePass,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.password),
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _togglePasswordvisibility();
                            },
                            child: Icon(
                              _isHidePass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _isHidePass ? Colors.black : Colors.black,
                            ),
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Isi password';
                          } else if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          password = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: _signUpButton(),
                    ),
                    _signInButton(context)
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/wallpaper2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )));
  }

  Widget _signUpButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // ignore: deprecated_member_use
        child: FlatButton(
          //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: Colors.green,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                final user = await AuthHelper.signupWithEmail(
                    email: _emailController.text,
                    password: _passController.text);
                    UserHelper.saveUser(user);
                if (user != null) {
                  Kebun.userUid = _auth.currentUser!.uid;
                  Qc.userUid = _auth.currentUser!.uid;
                  Inventory.userUid = _auth.currentUser!.uid;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: Text(e.toString()),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ]));
              }
              
            }
          },

          child: const Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Righteous', fontSize: 16),
          ),
        ),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/wallpaper2.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            "Already have an account ?",
            style:
                TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'NTR'),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Righteous',
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
