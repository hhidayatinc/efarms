import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/berita.dart';
import 'package:final_project/pages/admin/admin_berita.dart';
import 'package:final_project/pages/admin/admin_page.dart';
import 'package:final_project/pages/admin/edit_berita.dart';
import 'package:flutter/material.dart';

class BeritaPage extends StatefulWidget{
  const BeritaPage({Key? key}):super(key:key);
   @override
  BeritaPageState createState() => BeritaPageState();
}
class BeritaPageState extends State<BeritaPage>{
  var textNunitoSans = 'NunitoSans';
  var textNtr = 'NTR';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminHomePage()));
          },
        ),
        centerTitle: true,
        title: Text(
          'Berita List',
          style: TextStyle(
              fontSize: 20,
              fontFamily: textNunitoSans,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AdminBeritaPage(),
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
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/wallpaper3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: Berita.showberita(),
          builder: (context, snapshot){
            Widget widget =
                const Center(child: Text('Anda belum memiliki data berita'));
                if(snapshot.hasData){
                  return ListView.separated(itemBuilder: (context, index){
                            var beritaList = snapshot.data!.docs[index];
                    String beritaId = snapshot.data!.docs[index].id;
                    String judul = beritaList.get('judul_berita');
                    String konten = beritaList.get('konten_berita');
                    String tanggal = beritaList.get('tanggal');
                    String sumber = beritaList.get('sumber');
                    String gambar = beritaList.get('gambar');
                    return Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 7,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.all(10),
                          child: Image.network(gambar, width: 50, height: 50,),),
                          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(judul,
                            style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )
                            ),
                          ],)),
                          Padding(padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditBerita(gambar: gambar,judul:judul, konten:konten, tanggal:tanggal, sumber:sumber, beritaId:beritaId),));}, icon: const Icon(Icons.edit),
                                  color: Colors.grey,),
                                  IconButton(onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Konfirmasi'),
                                              content: const Text(
                                                  "Yakin menghapus data ini?"),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Batal")),
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                    onPressed: () async {
                                                      await Berita.deleteberita(beritaId: beritaId);
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Data berhasil di hapus!')));
                                                    },
                                                    child: const Text("Yes"))
                                              ],
                                            ));
                                  }, icon: const Icon(Icons.delete),
                                  color: Colors.grey,)
                            ],
                          ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: snapshot.data!.docs.length
                  );
                }
                 if (!snapshot.hasData) {
              return widget;
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
  
}