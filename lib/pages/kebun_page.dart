
// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/kebun.dart';
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
  var textNtr = 'NTR';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));},
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
      child: StreamBuilder<QuerySnapshot>(
        stream: Kebun.showKebun(),
        builder: (context, snapshot){
           Widget widget = const Center(child: Text('Anda belum memiliki data kebun'));
           if(snapshot.hasError){
            return widget;
           } else if(snapshot.hasData || snapshot.data != null){
            return ListView.separated(itemBuilder: (context, index) {
              var kebunList = snapshot.data!.docs[index];
              String kebunId = snapshot.data!.docs[index].id;
              String nama = kebunList['nama_kebun'];
              String alamat = kebunList['alamat_kebun'];
              String luas = kebunList['luas_kebun'];
              String komoditas = kebunList['komoditas_tanaman'];
              String jenis = kebunList['jenis_kebun'];

              return Container(
                height: 150.0,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Image.asset("assets/image/kebun.png"),),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('[$jenis]' ' $nama', style: TextStyle(fontFamily: textNtr, fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black,)),
                        const SizedBox(height: 5,),
                        Text('Lokasi: $alamat', style: TextStyle(fontFamily: textNtr, fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black,)),
                        const SizedBox(height: 5,),
                        Text('Komoditas: $komoditas', style: TextStyle(fontFamily: textNtr, fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black,)),
                        const SizedBox(height: 5,),
                        Text('Lokasi: $luas', style: TextStyle(fontFamily: textNtr, fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black,)),
                      ],
                    ),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.edit), color: Colors.grey,),
                        IconButton(onPressed: (){
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text("Yakin menghapus data ini?"),
                            actions: [
                              FlatButton(onPressed: (){Navigator.pop(context);}, child: const Text("Batal")),
                              // ignore: deprecated_member_use
                              FlatButton(onPressed: () async {await Kebun.deleteKebun(kebunId: kebunId); Navigator.pop(context);}, child: const Text("Yes"))
                            ],
                          ));
                        }, icon: const Icon(Icons.delete), color: Colors.grey,)
                      ],
                    ),)
                  ],
                ),
              );
            }, separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: snapshot.data!.docs.length);
            
           } return widget;
        },
      ),
      ),
    );
  }
}

