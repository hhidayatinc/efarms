import 'package:final_project/page/inventory_page.dart';
import 'package:final_project/page/kebun_page.dart';
import 'package:final_project/page/qc_page.dart';
import 'package:flutter/material.dart';

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
        body: Container(
      margin: EdgeInsetsDirectional.all(15),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/image/logokecil.png',
                  ),
                  Text(
                    'efarms',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontFamily: 'Righteous',
                        fontSize: 30),
                  ),
                  SizedBox(
                    width: 180,
                  ),
                  Icon(
                    Icons.people,
                    color: Colors.green,
                  )
                ],
              ),
              SizedBox(
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
              SizedBox(
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
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const QualityControl()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: 100,
                                height: 100,
                                decoration: boxDecoration(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/image/qc.png'),
                                    SizedBox(
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
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Kebun()));
                              },
                              child: Container(
                              padding: EdgeInsets.all(8),
                              width: 100,
                              height: 100,
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/kebun.png'),
                                  SizedBox(
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
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Inventory()));
                              },
                              child: Container(
                              padding: EdgeInsets.all(8),
                              width: 100,
                              height: 100,
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/inventory.png'),
                                  SizedBox(
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
                        padding: EdgeInsets.all(20),
                        child: ListView(scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Inventory()));
                              },
                              child: Container(
                                width: 150,
                              padding: EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/inventory.png'),
                                  SizedBox(
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
                            ),
                            SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Inventory()));
                              },
                              child: Container(
                                width: 150,
                              padding: EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/inventory.png'),
                                  SizedBox(
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
                            ),
                            SizedBox(width: 20,),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Inventory()));
                              },
                              child: Container(
                                width: 150,
                              padding: EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/image/inventory.png'),
                                  SizedBox(
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
                            ),
                            SizedBox(width: 10,),
                            
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
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
}
