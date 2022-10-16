import 'package:final_project/database/inventory.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/database/qc.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:final_project/register_page.dart';
import 'package:final_project/service/auth.dart';
import 'package:final_project/service/auth_email.dart';
import 'package:final_project/service/auth_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isHidePass = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
          child:Container(
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 130, bottom: 50),
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Righteous', 
                  color: Color(0xFF4CAF50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _passController,
              obscureText: _isHidePass,
              decoration: InputDecoration(
                hintText: 'Password',
                icon: Icon(Icons.password),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordvisibility();
                    },
                    child: Icon(
                      _isHidePass ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePass ? Colors.black : Colors.black,
                    ),
                  ),
                  isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              validator: (value){
                  if(value == null){
                   return 'Isi password';
                  } else if(value.length < 6){
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: _loginWithEmail(),
          ),
          const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: _loginWithGoogle(context)
          ),
          _registerButton(context)
        ],
      ),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/wallpaper1.png'),
          fit: BoxFit.cover,
        ),
      ),
          )
    ));
  }
   Widget _loginWithEmail() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // ignore: deprecated_member_use
        child: FlatButton(
          //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: Colors.green,
          onPressed: () async {
            if(_formKey.currentState!.validate()){
              SignInSignUpResult? result = await AuthService.signInWithEmail(
                email: _emailController.text, pass: _passController.text);
            // ignore: unnecessary_null_comparison
            if (result.user != null) {
              Kebun.userUid = _auth.currentUser!.uid;
              Qc.userUid = _auth.currentUser!.uid;
              Inventory.userUid = _auth.currentUser!.uid;
              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Berhasil masuk!')));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            // ignore: unnecessary_null_comparison
            } else if (result.user == null ){
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(result.message.toString()),
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
            "Sign in",
            style: TextStyle(color: Colors.white, fontFamily: 'Righteous', fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _loginWithGoogle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // ignore: deprecated_member_use
            child: FlatButton(
              //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: Colors.green,
              onPressed: () async{
              Kebun.userUid = _auth.currentUser!.uid;
              Qc.userUid = _auth.currentUser!.uid;
              Inventory.userUid = _auth.currentUser!.uid;
                User? user = await Authentication.signInWithGoogle(context: context);
                if(user != null){
                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Berhasil masuk!')));
                  Navigator.of(context)
                         .push(MaterialPageRoute(builder: (context) {
                       return const HomePage();
                     }));
                }
              },
              child: const Text(
                "Sign in With Google",
                style: TextStyle(color: Colors.white, fontFamily: 'Righteous', fontSize: 16),
              ),
            ),
          ),
        );
  }
  Widget _registerButton(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Don’t have an account ?",
                  style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'NTR'),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w700, fontFamily:'Righteous',fontSize: 20),
                  ),
                ),
              ],
            ),
            );
  }
}
