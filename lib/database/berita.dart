import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('efarms');

class Berita{
  static String messageAdd = "Data berita baru berhasil ditambahkan!";
  static String messageUpdate = "Data berita berhasil diperbarui!";
  static String messageDelete = "Data berita berhasil dihapus!";
  static String? userUid;
  static Future<void>? addNewberita({
    String? tanggal, 
    String? judul,
    String? konten,
    String? sumber,
    String? gambar
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('berita').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "tanggal" : tanggal,
      "judul_berita" : judul,
      "konten_berita" : konten,
      "sumber" : sumber,
      "gambar" : gambar,
    };

    await df.set(data).whenComplete(() => messageAdd).catchError((e) => print(e));
  }

  static Future<void>? updateberita({
    String? tanggal, 
    String? judul,
    String? konten,
    String? sumber,
    String? gambar,
    String? beritaId
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('berita').doc(beritaId);
    Map<String, dynamic> data = <String, dynamic>{
      "tanggal" : tanggal,
      "judul_berita" : judul,
      "konten_berita" : konten,
      "sumber" : sumber,
      "gambar" : gambar,
    };
    await df.update(data).whenComplete(() => messageUpdate).catchError((e) => print(e));
  }

  static Stream<QuerySnapshot>? showberita(){
    CollectionReference beritaCollection = _mainCollection.doc(userUid).collection('berita');
    return beritaCollection.snapshots();
  }
  static Future<void>? deleteberita({
    String? beritaId
  }) async{
    DocumentReference df = _mainCollection.doc(userUid).collection('berita').doc(beritaId);

    await df.delete().whenComplete(() => messageDelete).catchError((e) => print(e));
  }
}