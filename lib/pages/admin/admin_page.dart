import 'package:final_project/pages/admin/berita_list.dart';
import 'package:final_project/service/auth_helper.dart';
import 'package:final_project/login_page.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        leading: IconButton(icon: const Icon(Icons.logout), onPressed: (){
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
                                          const BeritaPage()));
            },
            child: Container(child: Column(
              children: const [
                Icon(Icons.article),
                Text("Berita")
              ],
            ),
            width: 100, height: 100,
            padding: const EdgeInsets.all(25),
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
           const SizedBox(width: 10,),
           InkWell(
           
            child: Container(child: Column(
              children: const [
                Icon(Icons.laptop_mac),
                Text("Webinar")
              ],
            ),
            width: 100, height: 100,padding: const EdgeInsets.all(20),
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