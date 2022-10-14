// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/qc.dart';
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
      child: StreamBuilder<QuerySnapshot>(
        stream: Qc.readQc(),
        builder: (context, snapshot){
           Widget widget = const Center(child: Text('Anda belum memiliki data kebun'));
           if(snapshot.hasError){
            return widget;
           } else if(snapshot.hasData || snapshot.data != null){
            return ListView.separated(itemBuilder: (context, index) {
              var qcList = snapshot.data!.docs[index];
              String qcId = snapshot.data!.docs[index].id;
              String tanggal = qcList['tanggal'];
              String kebun = qcList['kebun'];
              String listrik = qcList['listrik'];
              String ppmSebelum = qcList['ppmSebelum'];
              String ppmTambah = qcList['ppmTambah'];
              String ppmSesudah = qcList['ppmSesudah'];
              String phSebelum = qcList['phSebelum'];
              String phTambah = qcList['phTambah'];
              String phSesudah = qcList['phSesudah'];
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
                    child: Image.asset("assets/image/qc.png"),),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tanggal, style: TextStyle(fontFamily: textNtr, fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black,)),
                        const SizedBox(height: 5,),
                        Text('Kebun: $kebun', style: TextStyle(fontFamily: textNtr, fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black,)),
                        const SizedBox(height: 5,),
                        Text('PPM: $ppmSesudah', style: TextStyle(fontFamily: textNtr, fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black,)),
                        const SizedBox(height: 5,),
                        Text('pH: $phSesudah', style: TextStyle(fontFamily: textNtr, fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black,)),
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
                              FlatButton(onPressed: () async {await Qc.deleteQc(qcId: qcId); Navigator.pop(context);}, child: const Text("Yes"))
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

