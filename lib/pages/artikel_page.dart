
import 'package:final_project/database/artikel.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class ArtikelPage extends StatelessWidget {
  final Artikel artikel;

  const ArtikelPage({Key? key, required this.artikel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textNunitoSans = 'NunitoSans';
    var textNtr = 'NTR';
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
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        centerTitle: true,
        title: Text(
          'Artikel Pertanian',
          style: TextStyle(
              fontSize: 20,
              fontFamily: textNunitoSans,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(15),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 10,),
            Text(
              artikel.judul,
              style: TextStyle(
                  fontFamily: textNunitoSans,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20,),
            Center(
              child: Image.asset(artikel.gambar, fit: BoxFit.contain,),
            ),
            const SizedBox(height: 5,),
           
                Text("Tanggal: " + artikel.tanggal, style: TextStyle(
                  fontFamily: textNtr,
                  color: Colors.grey,
                  fontWeight: FontWeight.w100,
                  fontSize: 14),
              textAlign: TextAlign.left),
    
              
              const SizedBox(height: 10,),
              Text(artikel.konten, style: TextStyle(
                  fontFamily: textNunitoSans,
                  color: Colors.black,
                  // fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlign: TextAlign.justify),

              const SizedBox(height: 10,),
               Text("Sumber: " + artikel.sumber, style: TextStyle(
                  fontFamily: textNtr,
                  color: Colors.grey,
                  fontWeight: FontWeight.w100,
                  ),
              textAlign: TextAlign.left,),
          ],
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/wallpaper3.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
