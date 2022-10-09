import 'package:flutter/material.dart';

class Inventory extends StatefulWidget{
  const Inventory({Key? key}) : super(key: key);
  @override
 InventoryState createState() =>InventoryState();
}

class InventoryState extends State<Inventory>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Inventory Page')),
    );
  }
}

