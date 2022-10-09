import 'package:final_project/login_page.dart';
import 'package:final_project/pages/inventory_page.dart';
import 'package:final_project/pages/kebun_page.dart';
import 'package:final_project/pages/qc_page.dart';
import 'package:final_project/service/auth_google.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var textNunitoSans = 'Nunito Sans';
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.green,onPressed: 
      () async{
        String url ="https://wa.me/+6285235655323/?text=Hello";
        if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
      },
      child: Icon(Icons.chat,color: Colors.white,)),
        body: Container(
      margin: const EdgeInsetsDirectional.all(15),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
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
                  const SizedBox(
                    width: 160,
                  ),
                  IconButton(
                    icon: Icon(Icons.people),
                    onPressed: (){
                      signOutGoogle();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                    }
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(
                    "Selamat Datang Farmers!",
                    style: TextStyle(
                        fontFamily: textNunitoSans,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(
                    "Happy Farming!",
                    style: TextStyle(fontFamily: textNunitoSans, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        child: Text(
                          "Fitur Unggulan Kami",
                          style: TextStyle(
                              fontFamily: textNunitoSans,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        padding: const EdgeInsets.all(20),
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
                                          fontFamily: textNunitoSans, fontSize: 12),
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
                                        const KebunPage()));
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
                                        fontFamily: textNunitoSans, fontSize: 12),
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
                                        const Inventory()));
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
                                        fontFamily: textNunitoSans, fontSize: 12),
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
                      child: Container(
                        child: Text(
                          "Artikel Pertanian",
                          style: TextStyle(
                              fontFamily: textNunitoSans,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(20),
                        child: ListView(scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                              onTap: null,
                              child: Container(
                                width: 150,
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/kubis.png'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Kubis',
                                    style: TextStyle(
                                        fontFamily: textNunitoSans, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: null,
                              child: Container(
                                width: 150,
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/kubis.png'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Kubis',
                                    style: TextStyle(
                                        fontFamily: textNunitoSans, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            ),
                            const SizedBox(width: 20,),
                            InkWell(
                              onTap: null,
                              child: Container(
                                width: 150,
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/kubis.png'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Kubis',
                                    style: TextStyle(
                                        fontFamily: textNunitoSans, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            ),
                            const SizedBox(width: 10,),
                            
                        ],),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        child: Text(
                          "Sekilas Ilmu",
                          style: TextStyle(
                              fontFamily: textNunitoSans,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(20),
                        child: ListView(scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                              onTap:null,
                              child: Container(
                                width: 150,
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/video.png'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Webinar',
                                    style: TextStyle(
                                        fontFamily: textNunitoSans, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: null,
                              child: Container(
                                width: 150,
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/video.png'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Wbinar',
                                    style: TextStyle(
                                        fontFamily: textNunitoSans, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            ),
                            const SizedBox(width: 20,),
                            InkWell(
                              onTap: null,
                              child: Container(
                                width: 150,
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/video.png'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Webinar',
                                    style: TextStyle(
                                        fontFamily: textNunitoSans, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            ),
                            const SizedBox(width: 10,),
                            
                        ],),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
}
