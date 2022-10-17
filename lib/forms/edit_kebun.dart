import 'package:final_project/database/kebun.dart';
import 'package:final_project/pages/kebun_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditKebun extends StatefulWidget{
  final String currentNama;
  final String currentLuas;
  final String currentAlamat;
  final String currentJenis;
  final String currentKomoditas;
  final String docId;

  const EditKebun({Key? key, required this.currentNama, required this.currentAlamat, required this.currentLuas, required this.currentKomoditas, required this.currentJenis, required this.docId}) : super(key: key);

  @override
  EditKebunState createState() => EditKebunState();
  
}

class EditKebunState extends State<EditKebun>{
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
   TextEditingController _luasController = TextEditingController();
   TextEditingController _jenisController = TextEditingController();
   TextEditingController _komoditasController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var textNunitoSans = 'Nunito Sans';

  String? nama;
  String? alamat;
  String? luas;
  String? komoditas;
  String? jenis;

  @override
  void initState() {
    _namaController = TextEditingController(text: widget.currentNama);
    _alamatController = TextEditingController(text: widget.currentAlamat);
    _luasController = TextEditingController(text: widget.currentLuas);
    _komoditasController = TextEditingController(text: widget.currentKomoditas);
    _jenisController = TextEditingController(text: widget.currentJenis);
    super.initState();
  }
  
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
          title: Text('Edit Data Kebun',
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
                      } return null;
                    },
                    onSaved: (val){
                      nama =val;
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
                      } return null;
                    },
                    onSaved: (val){
                      alamat=val;
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
                      }return null;
                    },
                    onSaved: (val){
                      luas=val;
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
                      }return null;
                    },
                    onSaved: (val){
                      jenis=val;
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
                      }return null;
                    },
                    onSaved: (val){
                      komoditas=val;
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
                            await Kebun.updateKebun(
                                nama: nama,
                                alamat: alamat,
                                jenis: jenis,
                                komoditas: komoditas,
                                luas: luas);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Data kebun  berhasil diperbarui!')));
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
          ])),
        ));
  }
  }
  