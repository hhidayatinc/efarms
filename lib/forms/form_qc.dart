// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/database/qc.dart';
import 'package:final_project/pages/qc_page.dart';
import 'package:flutter/material.dart';

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
  DateTime _chooseDate = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  var selectedKebun;
  String textNunitoSans = 'Nunito Sans';
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
      child:ListView(
        padding: const EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(1), child:
                  DateTimeField(
                    onDateSelected: (DateTime value) {
                      setState(() {
                        _chooseDate = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Choose Date',
                      icon: const Icon(Icons.date_range),
                    ),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    mode: DateTimeFieldPickerMode.date,
                    selectedDate: _chooseDate,
                  ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                  stream: Kebun.showKebun(),
                  builder: (context, snapshot) {
                     Widget widget = const Center(child: Text('Tidak ada data'));
                    if(!snapshot.hasData){
                      return widget;
                    } else{
                      List<DropdownMenuItem> currencyKebun = [];
                      for(int i=0; i<snapshot.data!.docs.length; i++){
                        var snap = snapshot.data!.docs[i];
                        String kebun = snap['nama_kebun'];
                        currencyKebun.add(DropdownMenuItem(child: Text(kebun),
                        value: kebun,));
                      }
                      return Row(
                      children: <Widget>[
                    DropdownButton<dynamic>(
                      items: currencyKebun,
                      onChanged: (currencyValue) {
                        final snackBar = SnackBar(
                          content: Text(
                            'Selected Kebun is $currencyValue',
                            style: const TextStyle(color: Colors.white),
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
              )
            ],
          ),
          Padding(
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
            width: double.infinity,
            child: Text(
              "PPM (Nutrisi)",
              style: TextStyle(
                  fontFamily: textNunitoSans,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ppmWidget(
              textNunitoSans: textNunitoSans,
              ppmSebelumController: _ppmSebelumController,
              ppmTambahController: _ppmTambahController,
              ppmSesudahController: _ppmSesudahController),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Kadar pH",
              style: TextStyle(
                  fontFamily: textNunitoSans,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          phWidget(
              textNunitoSans: textNunitoSans,
              phSebelumController: _phSebelumController,
              phTambahController: _phTambahController,
              phSesudahController: _phSesudahController),
            const SizedBox(height: 20,),
            ButtonForm(chooseDate: _chooseDate, listrikController: _listrikController, ppmSebelumController: _ppmSebelumController, ppmTambahController: _ppmTambahController, ppmSesudahController: _ppmSesudahController, phSebelumController: _phSebelumController, phTambahController: _phTambahController)
        
        ],
      ),
      )
    );
  }
}

class ButtonForm extends StatelessWidget {
  const ButtonForm({
    Key? key,
    required DateTime chooseDate,
    required TextEditingController listrikController,
    required TextEditingController ppmSebelumController,
    required TextEditingController ppmTambahController,
    required TextEditingController ppmSesudahController,
    required TextEditingController phSebelumController,
    required TextEditingController phTambahController,
  }) : _chooseDate = chooseDate, _listrikController = listrikController, _ppmSebelumController = ppmSebelumController, _ppmTambahController = ppmTambahController, _ppmSesudahController = ppmSesudahController, _phSebelumController = phSebelumController, _phTambahController = phTambahController, super(key: key);

  final DateTime _chooseDate;
  final TextEditingController _listrikController;
  final TextEditingController _ppmSebelumController;
  final TextEditingController _ppmTambahController;
  final TextEditingController _ppmSesudahController;
  final TextEditingController _phSebelumController;
  final TextEditingController _phTambahController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              tanggal: _chooseDate.toString(),
              listrik: _listrikController.text,
              ppmSebelum: _ppmSebelumController.text,
              ppmTambah: _ppmTambahController.text,
              ppmSesudah: _ppmSesudahController.text,
              phSebelum: _phSebelumController.text,
              phTambah: _phTambahController.text,
              phSesudah: _phTambahController.text
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quality Control baru berhasil ditambahkan!')));
          Navigator.of(context).pop();
        },
        child: const Text(
          'Simpan',
          style: TextStyle(color: Colors.white),
        )),
          )
        ],
      ),
        
    );
  }
}

// ignore: camel_case_types
class phWidget extends StatelessWidget {
  const phWidget({
    Key? key,
    required this.textNunitoSans,
    required TextEditingController phSebelumController,
    required TextEditingController phTambahController,
    required TextEditingController phSesudahController,
  })  : _phSebelumController = phSebelumController,
        _phTambahController = phTambahController,
        _phSesudahController = phSesudahController,
        super(key: key);

  final String textNunitoSans;
  final TextEditingController _phSebelumController;
  final TextEditingController _phTambahController;
  final TextEditingController _phSesudahController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Column(
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
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
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
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
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
            ),
          ],
        ));
  }
}

// ignore: camel_case_types
class ppmWidget extends StatelessWidget {
  const ppmWidget({
    Key? key,
    required this.textNunitoSans,
    required TextEditingController ppmSebelumController,
    required TextEditingController ppmTambahController,
    required TextEditingController ppmSesudahController,
  })  : _ppmSebelumController = ppmSebelumController,
        _ppmTambahController = ppmTambahController,
        _ppmSesudahController = ppmSesudahController,
        super(key: key);

  final String textNunitoSans;
  final TextEditingController _ppmSebelumController;
  final TextEditingController _ppmTambahController;
  final TextEditingController _ppmSesudahController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Column(
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
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
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
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
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
            ),
          ],
        ));
  }
}
