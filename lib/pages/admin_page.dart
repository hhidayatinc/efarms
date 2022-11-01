import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/pages/admin_berita.dart';
import 'package:final_project/service/auth_helper.dart';
import 'package:final_project/login_page.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
        leading: IconButton(icon: Icon(Icons.logout), onPressed: (){
          AuthHelper.logOut();
           ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Berhasil keluar!')));
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage()));
        },),
      ),
      body: Center( child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
           InkWell(
             onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminBeritaPage()));
            },
            child: Container(child: Column(
              children: [
                Icon(Icons.article),
                Text("Berita")
              ],
            ),
            width: 100, height: 100,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(3, 3), // changes position of shadow
        ),
      ],),),
           ),
           SizedBox(width: 10,),
           InkWell(
           
            child: Container(child: Column(
              children: [
                Icon(Icons.laptop_mac),
                Text("Webinar")
              ],
            ),
            width: 100, height: 100,padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(3, 3), // changes position of shadow
        ),
      ],),),
           ),
          ],
        ),
      )
    );
  }
}