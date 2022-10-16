import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/inventory.dart';
import 'package:final_project/forms/form_inventory.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class InventoryPage  extends StatefulWidget{
  const InventoryPage({Key? key}) : super(key: key);
  @override
 InventoryPageState createState() =>InventoryPageState();
}

class InventoryPageState extends State<InventoryPage>{
 var textNunitoSans = 'NunitoSans';
 var textNtr = 'NTR';
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
                   String tglCatat = inventList.get('tanggal_catat');
                   String tglUpdate = inventList.get('tanggal_update');
                   String namaBrg = inventList.get('nama_barang');
                   String jmlhBrgAwal = inventList.get('jumlah_barang_awal');
                   String brgTerpakai = inventList.get('jumlah_barang_terpakai');
                   String sisa = inventList.get('jumlah_barang_saat_ini');

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
                            child: Image.asset("assets/image/kebun.png", width: 50, height: 50,),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tanggal Catat: $tglCatat',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )),
                                Text('Tanggal Update: $tglUpdate',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Text('Nama: $namaBrg',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Text('Kuantitas Barang: $jmlhBrgAwal',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                    Text('Barang Terpakai: $brgTerpakai',
                                    style: TextStyle(
                                      fontFamily: textNtr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                    Text('Sisa Barang: $sisa',
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
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
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
                                                      await Inventory.deleteIvent(
                                                          inventoryId: inventId);
                                                      Navigator.pop(context);
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
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}

