class DataPendudukModel {
  int? id;
  int? kecamatanId;
  String? nama;
  String? nik;
  String? telp;
  String? desaLurah;
  String? alamat;
  String? email;
  String? tempatLahir;
  String? tanggalLahir;
  String? jenisKelamin;
  String? createdAt;
  String? updatedAt;

  DataPendudukModel(
      {this.id,
      this.kecamatanId,
      this.nama,
      this.nik,
      this.telp,
      this.desaLurah,
      this.alamat,
      this.email,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.createdAt,
      this.updatedAt});

  DataPendudukModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kecamatanId = json['kecamatan_id'];
    nama = json['nama'];
    nik = json['nik'];
    telp = json['telp'];
    desaLurah = json['desa_lurah'];
    alamat = json['alamat'];
    email = json['email'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    jenisKelamin = json['jenis_kelamin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kecamatan_id'] = kecamatanId;
    data['nama'] = nama;
    data['nik'] = nik;
    data['telp'] = telp;
    data['desa_lurah'] = desaLurah;
    data['alamat'] = alamat;
    data['email'] = email;
    data['tempat_lahir'] = tempatLahir;
    data['tanggal_lahir'] = tanggalLahir;
    data['jenis_kelamin'] = jenisKelamin;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
