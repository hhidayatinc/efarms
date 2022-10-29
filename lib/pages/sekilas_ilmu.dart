import 'package:final_project/database/webinar.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebinarPage extends StatelessWidget {
  final Webinar webinar;

  const WebinarPage({Key? key, required this.webinar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textNunitoSans = 'NunitoSans';
    var textNtr = 'NTR';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          'Sekilas Ilmu',
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
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Image.asset(
                webinar.gambar,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webinar.judul,
              style: TextStyle(
                  fontFamily: textNunitoSans,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(height: 10,),
            Row(
              children: [Icon(Icons.date_range), Text(": " + webinar.tanggal)],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.watch_later_outlined),
                Text(": " + webinar.jam)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                Text(": " + webinar.platform)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.person_outlined),
                Text(": " + webinar.pemateri)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FlatButton(
                color: Colors.green,
                  child: Text("Daftar", style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    final url = webinar.url;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw "Could not launch $url";
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
