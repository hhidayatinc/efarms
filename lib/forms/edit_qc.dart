// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/database/qc.dart';
import 'package:final_project/pages/qc_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditQc extends StatefulWidget{
  final int currentListrik;
  final String currentppmSesudah;
  final String currentppmSebelum;
  final String currentppmTambah;
  final String currentphSebelum;
  final String currentphSesudah;
  final String currentphTambah;
  final String currentTgl;

  const EditQc({Key? key, required this.currentListrik, required this.currentphSebelum, required this.currentphSesudah, required this.currentphTambah, required this.currentppmSebelum, required this.currentppmTambah, required this.currentppmSesudah, required this.currentTgl}) : super(key: key);

  @override
  EditQcState createState() => EditQcState();
}

class EditQcState extends State<EditQc>{
   final _formKey = GlobalKey<FormState>();
   TextEditingController _listrikController = TextEditingController();
   TextEditingController _ppmSebelumController = TextEditingController();
   TextEditingController _ppmSesudahController = TextEditingController();
   TextEditingController _ppmTambahController = TextEditingController();
   TextEditingController _phSebelumController = TextEditingController();
   TextEditingController _phSesudahController = TextEditingController();
  TextEditingController _phTambahController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
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
    _dateController = TextEditingController(text: widget.currentTgl);
    _listrikController = TextEditingController(text: widget.currentListrik.toString());
    _ppmSebelumController = TextEditingController(text: widget.currentppmSebelum);
    _ppmSesudahController = TextEditingController(text: widget.currentppmSesudah);
    _ppmTambahController = TextEditingController(text: widget.currentppmTambah);
    _phSebelumController = TextEditingController(text: widget.currentphSebelum);
    _phSesudahController = TextEditingController(text: widget.currentphSesudah);
    _phTambahController = TextEditingController(text: widget.currentphTambah);
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
            "Edit Data QC",
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
                        keyboardType:TextInputType.text,
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
                            await Qc.updateQc(
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