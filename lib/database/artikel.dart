class Artikel{
  late int id;
  late String judul;
  late String tanggal;
  late String konten;
  late String gambar;
  late String sumber;

  Artikel(this.id, this.gambar, this.tanggal, this.judul, this.konten, this.sumber);

   Artikel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gambar = json['gambar'];
    tanggal = json['tanggal'];
    judul = json['judul'];
    sumber = json['sumber'];
    konten = json['konten'];
  }
}