// ignore_for_file: deprecated_member_use, duplicate_ignore, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/database/qc.dart';
import 'package:final_project/pages/qc_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormQc extends StatefulWidget {
  const FormQc({Key? key}) : super(key: key);

  @override
  FormQcState createState() => FormQcState();
}

class FormQcState extends State<FormQc> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _listrikController = TextEditingController();
  final TextEditingController _ppmSebelumController = TextEditingController();
  final TextEditingController _ppmSesudahController = TextEditingController();
  final TextEditingController _ppmTambahController = TextEditingController();
  final TextEditingController _phSebelumController = TextEditingController();
  final TextEditingController _phSesudahController = TextEditingController();
  final TextEditingController _phTambahController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  String? setDate;
  // ignore: prefer_typing_uninitialized_variables
  var selectedKebun;
  String textNunitoSans = 'Nunito Sans';

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
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QualityControl()));
            },
          ),
          title: const Text(
            "Tambah Data QC",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w600),
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
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.category, color: Colors.grey,),
                    SizedBox(width: 15,),
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
                  keyboardType: TextInputType.number,
                  controller: _listrikController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.electrical_services),
                    hintText: 'Listrik',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: Text(
                  "PPM (Nutrisi)",
                  style: TextStyle(
                      fontFamily: textNunitoSans,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              
              SizedBox(
                  child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Sebelum (Semai, Apung, Tandon)",
                        style: TextStyle(
                            fontFamily: textNunitoSans,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _ppmSebelumController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Tambah PPM (Semai, Apung, Tandon)",
                        style: TextStyle(
                            fontFamily: textNunitoSans,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _ppmTambahController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Sesudah PPM (Semai, Apung, Tandon)",
                        style: TextStyle(
                            fontFamily: textNunitoSans,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _ppmSesudahController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  )),
                ],
              )),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: Text(
                  "Kadar pH",
                  style: TextStyle(
                      fontFamily: textNunitoSans,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                  child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Sebelum PH(Semai, Apung, Tandon)",
                        style: TextStyle(
                            fontFamily: textNunitoSans,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _phSebelumController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Tambah PH (Semai, Apung, Tandon)",
                        style: TextStyle(
                            fontFamily: textNunitoSans,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _phTambahController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Sesudah PH(Semai, Apung, Tandon)",
                        style: TextStyle(
                            fontFamily: textNunitoSans,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _phSesudahController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  )),
                ],
              )),
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
                                                            const QualityControl()));
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
                            await Qc.addQc(
                                tanggal: selectedDate.toString(),
                                kebun: selectedKebun,
                                listrik: int.parse(_listrikController.text),
                                ppmSebelum: _ppmSebelumController.text,
                                ppmTambah: _ppmTambahController.text,
                                ppmSesudah: _ppmSesudahController.text,
                                phSebelum: _phSebelumController.text,
                                phTambah: _phTambahController.text,
                                phSesudah: _phTambahController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Quality Control baru berhasil ditambahkan!')));
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
        ));
  }
}
