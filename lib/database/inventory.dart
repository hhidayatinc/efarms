import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('efarms');

class Inventory {
  static String messageAdd = "Data inventory baru berhasil ditambahkan!";
  static String messageUpdate = "Data inventory berhasil diperbarui!";
  static String messageDelete = "Data inventory berhasil dihapus!";
  static String? userUid;
  static Future<void>? addInventory({
    String? tanggalCatat,
    String? tanggalUpdate,
    String? namaBarang,
    String? jumlahBrgAwal,
    String? brgTerpakai,
    String? sisa,
  }) async {
    DocumentReference df = _mainCollection.doc(userUid).collection('inventory').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "tanggal_catat" : tanggalCatat,
      "tanggal_update" : tanggalUpdate,
      "nama_barang" : namaBarang,
      "jumlah_barang_awal" : jumlahBrgAwal,
      "jumlah_barang_terpakai" : brgTerpakai,
      "jumlah_barang_saat_ini" : sisa
    };
    await df.set(data).whenComplete(() => messageAdd).catchError((e) => print(e));
  }

  static Future<void>? updateInventory({
    String? inventoryId,
    String? tanggalCatat,
    String? tanggalUpdate,
    String? namaBarang,
    String? jumlahBrgAwal,
    String? brgTerpakai,
    String? sisa,
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('inventory').doc(inventoryId);
     Map<String, dynamic> data = <String, dynamic>{
      "tanggal_catat" : tanggalCatat,
      "tanggal_update" : tanggalUpdate,
      "nama_barang" : namaBarang,
      "jumlah_barang_awal" : jumlahBrgAwal,
      "jumlah_barang_terpakai" : brgTerpakai,
      "jumlah_barang_saat_ini" : sisa
    };
     await df.update(data).whenComplete(() => messageUpdate).catchError((e) => print(e));
  }

  static Stream<QuerySnapshot>? readInvent(){
    CollectionReference inventoryCollection = _mainCollection.doc(userUid).collection('inventory');
    return inventoryCollection.snapshots();
  }
  static Future<void>? deleteIvent({
    String? inventoryId
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('inventory').doc(inventoryId);

    await df.delete().whenComplete(() => messageDelete).catchError((e) => print(e));
  }
}
