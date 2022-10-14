import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('efarms');

class Inventory{
  String? userid;
  
  static Future<void>? addInventory({
    String? tanggal,
  String? namaBarang,
  String? jumlahBrg,
  String? brgTerpakai,
  }) async {
    
  }
}