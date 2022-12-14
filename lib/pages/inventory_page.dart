// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/inventory.dart';
import 'package:final_project/pages/forms/edit_inventory.dart';
import 'package:final_project/pages/forms/form_inventory.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);
  @override
  InventoryPageState createState() => InventoryPageState();
}

class InventoryPageState extends State<InventoryPage> {
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
          'Data Inventori',
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
        child: StreamBuilder<QuerySnapshot>(
          stream: Inventory.readInvent(),
          builder: (context, snapshot) {
            Widget widget =
                const Center(child: Text('Anda belum memiliki data kebun'));
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var inventList = snapshot.data!.docs[index];
                    String inventId = snapshot.data!.docs[index].id;
                    String kebun = inventList.get('kebun');
                    String namaBrg = inventList.get('nama_barang');
                    double jmlhBrgAwal = inventList.get('jumlah_barang_awal');
                    double brgTerpakai =
                        inventList.get('jumlah_barang_terpakai');
                    double sisa = inventList.get('jumlah_barang_saat_ini');
                    String satuan = inventList.get('satuan');

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
                              "assets/image/inventory.png",
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('[$kebun]' ' - ' '$namaBrg',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )),
                                Text(
                                    'Kuantitas Barang: $jmlhBrgAwal' ' $satuan',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Text('Barang Terpakai: $brgTerpakai' ' $satuan',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Text('Sisa Barang: $sisa' ' $satuan',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditInventory(
                                          currentNama: namaBrg,
                                          currentJmlhBrg: jmlhBrgAwal,
                                          currentBrgTerpakai: brgTerpakai,
                                          currentSisa: sisa,
                                          docId: inventId,
                                          currentSatuan: satuan,
                                        ),
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
                                              // ignore: duplicate_ignore
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Batal")),
                                                FlatButton(
                                                    onPressed: () async {
                                                      await Inventory
                                                          .deleteIvent(
                                                              inventoryId:
                                                                  inventId);
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

  // Widget _search(){
  //   String? userUid;
  //   String? namaBarang;
  //  return StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('efarms').doc(userUid).collection('inventory').where('nama_barang', isEqualTo: namaBarang).snapshots(),
  //  builder: (context, snapshot){
  //   if(snapshot.connectionState == ConnectionState.waiting){
  //     return Center(child: CircularProgressIndicator(),);
  //   }
  //   else if(snapshot.connectionState == ConnectionState.done && !snapshot.hasData){
  //     return Center(child: Text("Barang tidak ada"),);
  //   } else if(snapshot.hasData){
  //     return ListView.builder(
  //       itemCount: snapshot.data!.docs.length,
  //       itemBuilder: (context, index) {
  //                   var inventList = snapshot.data!.docs[index];
  //                   String inventId = snapshot.data!.docs[index].id;
  //                   String namaBrg = inventList.dat
  //                   ;},
  //     );
  //   }
  //  }); 
  // }
}
