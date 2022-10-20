// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/inventory.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/pages/inventory_page.dart';
import 'package:flutter/material.dart';

class FormInventory extends StatefulWidget {
  const FormInventory({Key? key}) : super(key: key);

  @override
  FormInventoryState createState() => FormInventoryState();
}

class FormInventoryState extends State<FormInventory> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jmlhBrgController = TextEditingController();
  final TextEditingController _brgTerpakaiController = TextEditingController();
  final TextEditingController _satuanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var textNunitoSans = 'Nunito Sans';
  var selectedKebun;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const InventoryPage()));
          },
        ),
        title: const Text(
          "Tambah Data Inventory",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.category, color: Colors.grey,),
                    const SizedBox(width: 15,),
                    StreamBuilder<QuerySnapshot>(
                      stream: Kebun.showKebun(),
                      builder: (context, snapshot) {
                        Widget widget =
                            const Center(child: Text('Tidak ada data'));
                        if (!snapshot.hasData) {
                          return widget;
                        } else {
                          List<DropdownMenuItem> currencyKebun = [];
                          for (int i = 0;
                              i < snapshot.data!.docs.length;
                              i++) {
                            var snap = snapshot.data!.docs[i];
                            String kebun = snap['nama_kebun'];
                            currencyKebun.add(DropdownMenuItem(
                              child: Text(kebun),
                              value: kebun,
                            ));
                          }
                          return Row(
                            children: <Widget>[
                              DropdownButton<dynamic>(
                                items: currencyKebun,
                                onChanged: (currencyValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Selected Kebun is $currencyValue',
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedKebun = currencyValue;
                                  });
                                },
                                value: selectedKebun,
                                isExpanded: false,
                                hint: const Text(
                                  "Pilih Kebun",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                      )
                  ],
                ),
              ),
             
                    Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _namaController,
                        decoration: InputDecoration(
                          hintText: 'Nama Barang',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _satuanController,
                        decoration: InputDecoration(
                          hintText: 'Satuan Barang',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _jmlhBrgController,
                        decoration: InputDecoration(
                          hintText: 'Jumlah Barang awal',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _brgTerpakaiController,
                        decoration: InputDecoration(
                          hintText: 'Jumlah Barang Terpakai',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                      ),
                    ),
                  
                
              
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: const Text("Konfirmasi"),
                                        content: const Text(
                                            'Apakah anda yakin ingin membuang data ini?'),
                                        actions: <Widget>[
                                          // ignore: deprecated_member_use
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const InventoryPage()));
                                              },
                                              child: const Text("Ya")),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Tidak"))
                                        ]));
                          },
                          color: Colors.green,
                          child: const Text(
                            'Buang',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FlatButton(
                          color: Colors.green,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await Inventory.addInventory(
                                kebun: selectedKebun,
                                namaBarang: _namaController.text,
                                satuan: _satuanController.text,
                                jumlahBrgAwal: double.parse(_jmlhBrgController.text),
                                brgTerpakai: double.parse(_brgTerpakaiController.text),
                                sisa: double.parse(_jmlhBrgController.text) - double.parse(_brgTerpakaiController.text),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Data inventory baru berhasil ditambahkan!')));
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            'Simpan',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
