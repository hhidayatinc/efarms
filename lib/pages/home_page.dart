// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/database/artikel.dart';
import 'package:final_project/database/berita.dart';
import 'package:final_project/database/webinar.dart';
import 'package:final_project/login_page.dart';
import 'package:final_project/pages/artikel_page.dart';
import 'package:final_project/pages/sekilas_ilmu.dart';
import 'package:final_project/pages/inventory_page.dart';
import 'package:final_project/pages/kebun_page.dart';
import 'package:final_project/pages/qc_page.dart';
import 'package:final_project/service/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List<Artikel>> readJsonData() async {
    final data = await rootBundle.loadString('assets/data/artikel.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Artikel.fromJson(e)).toList();
  }

  Future<List<Webinar>> readJsonWebinar() async {
    final data = await rootBundle.loadString('assets/data/webinar.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Webinar.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textNunitoSans = 'Nunito Sans';
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () async {
              Uri url =
                  "https://wa.me/+6287883858724/?text=Hai Arta, saya mau konsultasi"
                      as Uri;
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw "Could not launch $url";
              }
            },
            child: const Icon(
              Icons.chat,
              color: Colors.white,
            )),
        body: Container(
          //margin: const EdgeInsetsDirectional.all(15),
          child: ListView(
            padding: const EdgeInsets.all(15),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(height: 10,),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/logokecil.png',
                      ),
                      const Text(
                        'efarms',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontFamily: 'Righteous',
                            fontSize: 30),
                      ),
                      IconButton(
                          icon: const Icon(Icons.people),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Konfirmasi"),
                                      content:
                                          const Text("keluar dari aplikasi?"),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Tidak")),
                                        FlatButton(
                                            onPressed: () {
                                              AuthHelper.logOut();
                                              //signOutGoogle();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Berhasil keluar!')));
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage()));
                                            },
                                            child: const Text('Ya'))
                                      ],
                                    ));
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Selamat Datang Farmers!",
                      style: TextStyle(
                          fontFamily: textNunitoSans,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Happy Farming!",
                      style:
                          TextStyle(fontFamily: textNunitoSans, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Fitur Unggulan Kami",
                          style: TextStyle(
                              fontFamily: textNunitoSans,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const QualityControl()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 100,
                                  height: 100,
                                  decoration: boxDecoration(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/image/qc.png'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Quality Control',
                                        style: TextStyle(
                                            fontFamily: textNunitoSans,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const KebunPage()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 100,
                                  height: 100,
                                  decoration: boxDecoration(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/image/kebun.png'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Kebunku',
                                        style: TextStyle(
                                            fontFamily: textNunitoSans,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const InventoryPage()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 100,
                                  height: 100,
                                  decoration: boxDecoration(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/image/inventory.png'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Inventory',
                                        style: TextStyle(
                                            fontFamily: textNunitoSans,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Artikel Pertanian",
                          style: TextStyle(
                              fontFamily: textNunitoSans,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                          height: 200,
                          child: FutureBuilder(
                            future: readJsonData(),
                            builder: (context, data) {
                              if (data.hasError) {
                                return Center(
                                  child: Text("${data.error}"),
                                );
                              } else if (data.hasData) {
                                var items = data.data as List<Artikel>;
                                return ListView.builder(
                                  itemCount: items.isEmpty ? 0 : items.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(padding: const EdgeInsets.all(8),
                                        decoration: boxDecoration(),width: 180.0,child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ArtikelPage(artikel: items[index])));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(items[index].gambar,
                                              fit: BoxFit.fitWidth,),
                                          const SizedBox(height: 5),
                                          Text(
                                            items[index].tanggal,
                                            style: TextStyle(
                                                fontFamily: textNunitoSans,
                                                fontSize: 12,
                                                color: Colors.grey),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            items[index].judul,
                                            style: TextStyle(
                                                fontFamily: textNunitoSans,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                    )
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
            //               child: StreamBuilder<QuerySnapshot>(stream: Berita.showberita(),builder: (context, snapshot){
            //                 Widget widget =
            //     const Center(child: Text('Anda belum memiliki data kebun'));
            //     if(snapshot.hasData){
            //       return ListView.builder(itemBuilder: (context, index){
            //         var beritaList = snapshot.data!.docs[index];
            //         //String beritaId = snapshot.data!.docs[index].id;
            //         String judul = beritaList.get('judul_berita');
            //         //String konten = beritaList.get('konten_berita');
            //         String tanggal = beritaList.get('tanggal');
            //         //String sumber = beritaList.get('sumber');
            //         //String gambar = beritaList.get('gambar');
            //         return Container(
            //           padding: const EdgeInsets.all(8),
            //                             decoration: boxDecoration(),width: 180.0,child: InkWell(
            //                           onTap: (){
            //                             //Navigator.push(context, MaterialPageRoute(builder: (context) => ArtikelPage(artikel: items[index])));
            //                           },
            //           child: Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                             children: [
            //                               Image.network("https://distan.bulelengkab.go.id/public/uploads/konten/21_memanen-dan-menanam-kembali-sawi-hijau-di-lahan-bpp-buleleng.jpeg",
            //                                   fit: BoxFit.fitWidth,),
            //                               const SizedBox(height: 5),
            //                               Text(
            //                                 tanggal,
            //                                 style: TextStyle(
            //                                     fontFamily: textNunitoSans,
            //                                     fontSize: 12,
            //                                     color: Colors.grey),
            //                                 textAlign: TextAlign.left,
            //                               ),
            //                               Text(
            //                                 judul,
            //                                 style: TextStyle(
            //                                     fontFamily: textNunitoSans,
            //                                     fontWeight: FontWeight.w600,
            //                                     fontSize: 12,
            //                                     color: Colors.black),
            //                                 textAlign: TextAlign.left,
            //                               )
            //                             ],
            //                           ),


            //         ));
            //       }, itemCount: snapshot.data!.docs.length,);
            //     } if (!snapshot.hasData) {
            //   return widget;
            // } else {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            //               },)
                        ),
                      
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Sekilas Ilmu",
                          style: TextStyle(
                              fontFamily: textNunitoSans,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                          height: 200,
                          child: FutureBuilder(
                            future: readJsonWebinar(),
                            builder: (context, data) {
                              if (data.hasError) {
                                return Center(
                                  child: Text("${data.error}"),
                                );
                              } else if (data.hasData) {
                                var items = data.data as List<Webinar>;
                                return ListView.builder(
                                  itemCount: items.isEmpty ? 0 : items.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(padding: const EdgeInsets.all(8),
                                        decoration: boxDecoration(),width: 180.0,child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => WebinarPage(webinar: items[index])));
                                      },
                                      child: 
                                          Image.asset(items[index].gambar,
                                              fit: BoxFit.contain,),
                                          
                                        
                                    )
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/wallpaper3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(3, 3), // changes position of shadow
        ),
      ],
    );
  }
}
