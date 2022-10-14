// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:final_project/database/kebun.dart';
import 'package:final_project/pages/kebun_page.dart';
import 'package:flutter/material.dart';

class FormKebun extends StatefulWidget {
  const FormKebun({Key? key}) : super(key: key);

  @override
  FormKebunState createState() => FormKebunState();
}

class FormKebunState extends State<FormKebun> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _luasController = TextEditingController();
  final TextEditingController _jenisController = TextEditingController();
  final TextEditingController _komoditasController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var textNunitoSans = 'Nunito Sans';
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
                  MaterialPageRoute(builder: (context) => const KebunPage()));
            },
          ),
          title: Text('Tambah Data Kebun',
              style: TextStyle(
                  fontFamily: textNunitoSans,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20)),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Center(
              child:
                  ListView(physics: const BouncingScrollPhysics(), children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset('assets/image/lokasi.png'),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _namaController,
                    decoration: InputDecoration(
                      hintText: 'Nama Kebun',
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
                    controller: _alamatController,
                    decoration: InputDecoration(
                      hintText: 'Alamat/Lokasi Kebun',
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
                    controller: _luasController,
                    decoration: InputDecoration(
                      hintText: 'Luas Kebun',
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
                    controller: _jenisController,
                    decoration: InputDecoration(
                      hintText: 'Jenis Kebun',
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
                    controller: _komoditasController,
                    decoration: InputDecoration(
                      hintText: 'Komoditas Tanaman',
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
                                                          const KebunPage()));
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
                            await Kebun.addNewKebun(
                                nama: _namaController.text,
                                alamat: _alamatController.text,
                                jenis: _jenisController.text,
                                komoditas: _komoditasController.text,
                                luas: _luasController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Data kebun baru berhasil ditambahkan!')));
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
          ])),
        ));
  }
}
