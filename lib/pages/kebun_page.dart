// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/forms/edit_kebun.dart';
import 'package:final_project/forms/form_kebun.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class KebunPage extends StatefulWidget {
  const KebunPage({Key? key}) : super(key: key);
  @override
  KebunPageState createState() => KebunPageState();
}

class KebunPageState extends State<KebunPage> {
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
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        centerTitle: true,
        title: Text(
          'Kebunku',
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
          builder: (context, snapshot) {
            Widget widget =
                const Center(child: Text('Anda belum memiliki data kebun'));
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var kebunList = snapshot.data!.docs[index];
                    String kebunId = snapshot.data!.docs[index].id;
                    String nama = kebunList.get('nama_kebun');
                    String alamat = kebunList.get('alamat_kebun');
                    String luas = kebunList.get('luas_kebun');
                    String komoditas = kebunList.get('komoditas_tanaman');
                    String jenis = kebunList.get('jenis_kebun');

                    return Container(
                      height: 150.0,
                      margin: const EdgeInsets.all(8),
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
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/image/kebun.png",
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('[$jenis]' ' $nama',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )),
                                Text('Lokasi: $alamat',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Text('Komoditas: $komoditas',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Text('Lokasi: $luas',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditKebun(currentAlamat: alamat, currentJenis: jenis, currentKomoditas: komoditas, currentLuas: luas, currentNama: nama, docId: kebunId),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  onPressed: () {
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
                                                      await Kebun.deleteKebun(
                                                          kebunId: kebunId);
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
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.grey,
                                )
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
                  itemCount: snapshot.data!.docs.length);
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
