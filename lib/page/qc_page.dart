import 'package:flutter/material.dart';

class QualityControl extends StatefulWidget{
  const QualityControl({Key? key}) : super(key: key);
  @override
  QualityControlState createState() => QualityControlState();
}

class QualityControlState extends State<QualityControl>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Quality Control Page')),
    );
  }
}

