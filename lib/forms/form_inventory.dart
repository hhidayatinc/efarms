import 'package:final_project/forms/form_kebun.dart';
import 'package:flutter/material.dart';

class FormInventory extends StatefulWidget {
  const FormInventory({Key? key}) : super(key: key);

  @override
  FormInventoryState createState() => FormInventoryState();
}

class FormInventoryState extends State<FormInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => FormKebun())); },
        ),
        title: Text("Tambah Data Inventory", style: TextStyle(color: Colors.black, fontFamily: 'NunitoSans', fontWeight: FontWeight.w600, fontSize: 20),),
        centerTitle: true,
        backgroundColor: Colors.white,),);
  }
}
