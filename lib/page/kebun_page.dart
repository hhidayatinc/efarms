import 'package:flutter/material.dart';

class Kebun extends StatefulWidget{
  const Kebun({Key? key}) : super(key: key);
  @override
  KebunState createState() => KebunState();
}

class KebunState extends State<Kebun>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Kebun Page')),
    );
  }
}

