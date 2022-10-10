import 'package:final_project/forms/form_qc.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class QualityControl extends StatefulWidget{
  const QualityControl({Key? key}) : super(key: key);
  @override
  QualityControlState createState() => QualityControlState();
}

class QualityControlState extends State<QualityControl>{
  var textNunitoSans='Nunito Sans';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},
        ),
        centerTitle: true,
        title: Text('Quality Control', style: TextStyle(fontSize: 20, fontFamily: textNunitoSans, fontWeight: FontWeight.w600, color: Colors.black),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormQc(),
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

