import 'package:final_project/page/home_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
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
            padding: const EdgeInsets.all(10),
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
            padding: const EdgeInsets.all(15),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: MaterialButton(
                minWidth: 300.0,
                height: 50.0,
                onPressed: () {},
                color: Colors.green,
                child: const Text('Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nunito-Sans')),
                        onLongPress: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));},
              ),
            ),
          ),
         

        ],
      ),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/wallpaper2.png'),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
