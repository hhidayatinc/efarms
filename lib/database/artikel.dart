class Artikel{
  late int id;
  late String judul;
  late String tanggal;
  late String konten;
  late String gambar;

  Artikel(this.id, this.gambar, this.tanggal, this.judul, this.konten);

   Artikel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gambar = json['gambar'];
    tanggal = json['tanggal'];
    judul = json['judul'];
    konten = json['konten'];
  }
}