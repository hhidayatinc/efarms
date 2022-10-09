import 'package:final_project/pages/qc_page.dart';
import 'package:flutter/material.dart';

class FormQc extends StatefulWidget{
  const FormQc({Key? key}) : super(key: key);

  @override
  FormQcState createState() => FormQcState();
}

class FormQcState extends State<FormQc>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => QualityControl())); },
        ),
        title: Text("Tambah Data QC", style: TextStyle(color: Colors.black, fontFamily: 'NunitoSans', fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: Colors.white,),
    );
  }
  
}