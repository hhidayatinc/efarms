// ignore_for_file: deprecated_member_use

import 'package:date_field/date_field.dart';
import 'package:final_project/database/inventory.dart';
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
  final TextEditingController _sisaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var textNunitoSans = 'Nunito Sans';
  DateTime? _tglCatat = DateTime.now();
  DateTime? _tglUpdate = DateTime.now();
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
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: DateTimeField(
                        onDateSelected: (DateTime value) {
                          setState(() {
                            _tglCatat = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Tanggal Entry Data',
                          icon: const Icon(Icons.date_range),
                        ),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                        mode: DateTimeFieldPickerMode.date,
                        selectedDate: _tglCatat,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: DateTimeField(
                      onDateSelected: (DateTime value) {
                        setState(() {
                          _tglUpdate = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelText: 'Tanggal Update Data',
                        icon: const Icon(Icons.date_range),
                      ),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      mode: DateTimeFieldPickerMode.date,
                      selectedDate: _tglUpdate,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _sisaController,
                        decoration: InputDecoration(
                          hintText: 'Jumlah Barang Saat ini',
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                                tanggalCatat: _tglCatat.toString(),
                                tanggalUpdate: _tglUpdate.toString(),
                                namaBarang: _namaController.text,
                                jumlahBrgAwal: _jmlhBrgController.text,
                                brgTerpakai: _brgTerpakaiController.text,
                                sisa: _sisaController.text,
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
