import 'package:final_project/pages/admin/admin_berita.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditBerita extends StatefulWidget{
  final String tanggal;
  final String judul;
  final String konten;
  final String sumber;
  final String gambar;
  final String beritaId;
  const EditBerita({Key? key,
  required this.judul,
  required this.konten,
  required this.gambar,
  required this.sumber,
  required this.tanggal,
  required this.beritaId
  }): super(key: key);
  @override
  EditBeritaState createState() => EditBeritaState();
}
class EditBeritaState extends State<EditBerita>{
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? setDate;
  TextEditingController _judulController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _sumberController = TextEditingController();
  TextEditingController _kontenController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
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
        _tanggalController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }
  @override
  void initState() {
    _tanggalController = TextEditingController(text: widget.tanggal);
    _gambarController = TextEditingController(text: widget.gambar);
    _judulController = TextEditingController(text: widget.judul);
    _sumberController = TextEditingController(text: widget.sumber);
    _kontenController = TextEditingController(text: widget.konten);
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
                  MaterialPageRoute(builder: (context) => const AdminBeritaPage()));
            },
          ),
          title: const Text('Edit Berita',
              style: TextStyle(
                  
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20)),
          centerTitle: true,
        ),
    );
  }
  
}