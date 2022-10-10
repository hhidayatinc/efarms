import 'package:final_project/forms/form_inventory.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget{
  const Inventory({Key? key}) : super(key: key);
  @override
 InventoryState createState() =>InventoryState();
}

class InventoryState extends State<Inventory>{
 var textNunitoSans = 'NunitoSans';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())); },
        ),
        centerTitle: true,
        title: Text('Data Inventori', style: TextStyle(fontSize: 20, fontFamily: textNunitoSans, fontWeight: FontWeight.w600, color: Colors.black),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormInventory(),
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

