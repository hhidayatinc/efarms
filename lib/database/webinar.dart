class Webinar{
  late int id;
  late String judul;
  late String tanggal;
  late String pemateri;
  late String gambar;
  late String jam;
  late String platform;
  late String url;

  Webinar(this.id, this.gambar, this.tanggal, this.judul, this.pemateri, this.platform, this.jam, this.url);

   Webinar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gambar = json['gambar'];
    tanggal = json['tanggal'];
    judul = json['judul'];
    platform = json['platform'];
    pemateri = json['pemateri'];
    jam = json['jam'];
    url= json['url'];
  }
}