
import 'package:final_project/forms/form_kebun.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class KebunPage extends StatefulWidget{
  const KebunPage({Key? key}) : super(key: key);
  @override
  KebunPageState createState() => KebunPageState();
}

class KebunPageState extends State<KebunPage>{
  var textNunitoSans = 'NunitoSans';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},
        ),
        centerTitle: true,
        title: Text('Kebunku', style: TextStyle(fontSize: 20, fontFamily: textNunitoSans, fontWeight: FontWeight.w600, color: Colors.black),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormKebun(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/wallpaper3.png'),
          fit: BoxFit.cover,
        ),
      ),
      ),
    );
  }
}

