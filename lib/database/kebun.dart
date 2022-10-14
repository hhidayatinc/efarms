import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('efarms');

class Kebun{
  static String messageAdd = "Data kebun baru berhasil ditambahkan!";
  static String messageUpdate = "Data kebun berhasil diperbarui!";
  static String messageDelete = "Data kebun berhasil dihapus!";
  static String? userUid;
  static Future<void>? addNewKebun({
    String? nama, 
    String? alamat,
    String? luas,
    String? komoditas,
    String? jenis
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('kebun').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama_kebun" : nama,
      "alamat_kebun" : alamat,
      "luas_kebun" : luas,
      "komoditas_tanaman" : komoditas,
      "jenis_kebun" : jenis
    };

    await df.set(data).whenComplete(() => messageAdd).catchError((e) => print(e));
  }

  static Future<void>? updateKebun({
    String? nama, 
    String? alamat,
    String? luas,
    String? komoditas,
    String? jenis,
    String? kebunId
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('kebun').doc(kebunId);
    Map<String, dynamic> data = <String, dynamic>{
      "nama_kebun" : nama,
      "alamat_kebun" : alamat,
      "luas_kebun" : luas,
      "komoditas_tanaman" : komoditas,
      "jenis_kebun" : jenis
    };
    await df.update(data).whenComplete(() => messageUpdate).catchError((e) => print(e));
  }

  static Stream<QuerySnapshot>? showKebun(){
    CollectionReference kebunCollection = _mainCollection.doc(userUid).collection('kebun');
    return kebunCollection.snapshots();
  }
  static Future<void>? deleteKebun({
    String? kebunId
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('kebun').doc(kebunId);

    await df.delete().whenComplete(() => messageDelete).catchError((e) => print(e));
  }
}