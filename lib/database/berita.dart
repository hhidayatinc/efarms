import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    

    Map<String, dynamic> data = <String, dynamic>{
      "tanggal" : tanggal,
      "judul_berita" : judul,
      "konten_berita" : konten,
      "sumber" : sumber,
      "gambar" : gambar,
    };

    await _firestore.collection("article").doc().set(data);
  }

  static Future<void>? updateberita({
    String? tanggal, 
    String? judul,
    String? konten,
    String? sumber,
    String? gambar,
    String? beritaId
  }) async{
    
    Map<String, dynamic> data = <String, dynamic>{
      "tanggal" : tanggal,
      "judul_berita" : judul,
      "konten_berita" : konten,
      "sumber" : sumber,
      "gambar" : gambar,
    };
    await _firestore.collection("article").doc(beritaId).update(data);
  }

  static Stream<QuerySnapshot>? showberita(){
    CollectionReference beritaCollection = _firestore.collection("article");
    return beritaCollection.snapshots();
  }
  static Future<void>? deleteberita({
    String? beritaId
  }) async{
    await _firestore.collection("article").doc(beritaId).delete();
  }

  static Future<void>? uploadImage(File imageFile) async{
    String fileName=basename(imageFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);
   uploadTask.then((res) {
   res.ref.getDownloadURL();
   
});
  }
}