
// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:final_project/database/artikel.dart';
import 'package:final_project/database/berita.dart';
import 'package:final_project/pages/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AdminBeritaPage extends StatefulWidget{
  const AdminBeritaPage({Key? key}) : super(key: key);
  @override
  _AdminBeritaState createState() => _AdminBeritaState();
}

class _AdminBeritaState extends State<AdminBeritaPage>{
  final TextEditingController _kontenController = TextEditingController();
  final TextEditingController _sumberController = TextEditingController();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _gambarController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  File? image;
  // ignore: prefer_typing_uninitialized_variables
  String? setDate;
  // ignore: prefer_typing_uninitialized_variables
  var selectedKebun;
  String textNunitoSans = 'Nunito Sans';
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List berita"),),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            physics: const BouncingScrollPhysics(),
            children: [
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _dateController,
                    onSaved: (String? val) {
                      setDate = val;
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.date_range),
                      hintText: 'Date',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
              ),
             
               Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _judulController,
                    decoration: InputDecoration(
                      hintText: 'Judul',
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
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    controller: _kontenController,
                    decoration: InputDecoration(
                      hintText: 'Isi',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    // validator: (value) {
                    //   if (value == null) {
                    //     return 'Please fill this section';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _sumberController,
                    decoration: InputDecoration(
                      hintText: 'Sumber',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    // validator: (value) {
                    //   if (value == null) {
                    //     return 'Please fill this section';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: RaisedButton(onPressed: 
() async{
  try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
if(image == null) return;
final imageTemp = File(image.path);
setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
}),
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
                                        // ignore: duplicate_ignore
                                        actions: <Widget>[
                                          // ignore: deprecated_member_use
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AdminHomePage()));
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
                            await Berita.addNewberita(
                              judul: _judulController.text,
                              konten: _kontenController.text,
                              tanggal: selectedDate.toString(),
                              sumber: _sumberController.text,
                              gambar: _gambarController.text
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Berita baru berhasil ditambahkan!')));
                            Navigator.of(context).pop();
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
          ),
        )
    );
  }
  
}

