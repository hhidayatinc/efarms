import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('efarms');

class Qc {
  static String messageAdd = "Data QC berhasil ditambahkan!";
  static String messageUpdate = "Data QC berhasil diperbarui!";
  static String messageDelete = "Data QC berhasil dihapus!";
  static String? userUid;
  static Future<void>? addQc({
    String? tanggal,
    String? kebun,
    int? listrik,
    String? ppmSebelum,
    String? ppmSesudah,
    String? ppmTambah,
    String? phSebelum,
    String? phSesudah,
    String? phTambah,
  }) async {
    DocumentReference df = _mainCollection.doc(userUid).collection('qc').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "tanggal": tanggal,
      "kebun": kebun,
      "listrik": listrik,
      "ppmSebelum": ppmSebelum,
      "ppmSesudah": ppmSesudah,
      "ppmTambah": ppmTambah,
      "phSebelum": phSebelum,
      "phSesudah": phSesudah,
      "phTambah": phTambah,
    };
    await df
        .set(data)
        .whenComplete(() => messageAdd)
        .catchError((e) => print(e));
  }

  static Future<void>? updateQc({
    String? qcId,
    String? tanggal,
    String? kebun,
    int? listrik,
    String? ppmSebelum,
    String? ppmSesudah,
    String? ppmTambah,
    String? phSebelum,
    String? phSesudah,
    String? phTambah,
  }) async {
    DocumentReference df =
        _mainCollection.doc(userUid).collection('qc').doc(qcId);
    Map<String, dynamic> data = <String, dynamic>{
      "tanggal": tanggal,
      "kebun": kebun,
      "listrik": listrik,
      "ppmSebelum": ppmSebelum,
      "ppmSesudah": ppmSesudah,
      "ppmTambah": ppmTambah,
      "phSebelum": phSebelum,
      "phSesudah": phSesudah,
      "phTambah": phTambah,
    };
    await df
        .update(data)
        .whenComplete(() => messageUpdate)
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot>? readQc() {
    CollectionReference qcCollection =
        _mainCollection.doc(userUid).collection('qc');
    return qcCollection.snapshots();
  }

  static Future<void>? deleteQc({String? qcId}) async {
    DocumentReference df =
        _mainCollection.doc(userUid).collection('qc').doc(qcId);

    await df
        .delete()
        .whenComplete(() => messageDelete)
        .catchError((e) => print(e));
  }
}
