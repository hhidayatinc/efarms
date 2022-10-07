import 'package:final_project/home_page.dart';
import 'package:final_project/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 130, bottom: 50),
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: MaterialButton(
                minWidth: 300.0,
                height: 50.0,
                onPressed: () {},
                color: Colors.green,
                child: Text('Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nunito-Sans')),
                        onLongPress: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));},
              ),
            ),
          ),
          Padding(padding:EdgeInsets.only(left: 90),child: Text(
              'Dont have an account?',
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'NTR',
                  fontSize: 20),
            ),),
             TextButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));}, child: const Text('Sign Up', style: TextStyle(fontSize: 20, color: Colors.green),)),

        ],
      ),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/wallpaper1.png'),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
