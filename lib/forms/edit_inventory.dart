import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/inventory.dart';
import 'package:final_project/database/kebun.dart';
import 'package:final_project/pages/inventory_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditInventory extends StatefulWidget{
  final String currentNama;
  final String currentJmlhBrg;
  final String currentBrgTerpakai;
  final String currentSisa;
  final String currentTglCatat;
  final String currentTglUpdate;
  final String docId;

  const EditInventory({Key? key, required this.currentNama, required this.currentJmlhBrg, required this.currentBrgTerpakai, required this.currentSisa, required this.currentTglCatat, required this.currentTglUpdate, required this.docId}) : super(key: key);
  
  @override
  EditInventoryState createState() => EditInventoryState();
}

class EditInventoryState extends State<EditInventory>{
  TextEditingController _namaController = TextEditingController();
  TextEditingController _jmlhBrgController = TextEditingController();
   TextEditingController _brgTerpakaiController = TextEditingController();
   TextEditingController _sisaController = TextEditingController();
   TextEditingController _tglCatatController = TextEditingController();
   TextEditingController _tglUpdateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var textNunitoSans = 'Nunito Sans';
  DateTime tglCatat = DateTime.now();
  DateTime tglUpdate = DateTime.now();
  var selectedKebun;
  String? setTglCatat;
  String? setTglUpdate;
  String? nama;
  String? jmlhBrg;
  String? brgTerpakai;
  String? sisa;

  Future<void> _selectTglCatat(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tglCatat,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        tglCatat = picked;
        _tglCatatController.text = DateFormat.yMd().format(tglCatat);
      });
    }
  }

  Future<void> _selectTglUpdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tglUpdate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        tglUpdate = picked;
        _tglUpdateController.text = DateFormat.yMd().format(tglUpdate);
      });
    }
  }

  @override
  void initState() {
    // _tglCatatController.text = DateFormat.yMd().format(DateTime.now());
    // _tglUpdateController.text = DateFormat.yMd().format(DateTime.now());
    _namaController = TextEditingController(text: widget.currentNama);
  _jmlhBrgController = TextEditingController(text: widget.currentJmlhBrg);
   _brgTerpakaiController = TextEditingController(text: widget.currentBrgTerpakai);
   _sisaController = TextEditingController(text: widget.currentSisa);
   _tglCatatController = TextEditingController(text: widget.currentTglCatat);
   _tglUpdateController = TextEditingController(text: widget.currentTglUpdate);
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const InventoryPage()));
          },
        ),
        title: const Text(
          "Edit Data Inventory",
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
              InkWell(
                onTap: () {
                  _selectTglCatat(context);
                },
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _tglCatatController,
                    onSaved: (String? val) {
                      setTglCatat = val;
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.date_range),
                      hintText: 'Tanggal Catat',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _selectTglUpdate(context);
                },
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _tglUpdateController,
                    onSaved: (String? val) {
                      setTglUpdate = val;
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.date_range),
                      hintText: 'Tanggal Update',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
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
                        onSaved: (val){
                          nama=val;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
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
                        onSaved: (val){
                          jmlhBrg = val;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
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
                        onSaved: (val){
                          brgTerpakai=val;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
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
                        onSaved: (val){
                          sisa=val;
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
                              await Inventory.updateInventory(
                                inventoryId: widget.docId,
                                kebun: selectedKebun,
                                tanggalCatat: tglCatat.toString(),
                                tanggalUpdate: tglUpdate.toString(),
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