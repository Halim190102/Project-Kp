class DataKecamatanModel {
  String? message;
  List<Data>? data;

  DataKecamatanModel({this.message, this.data});

  DataKecamatanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? kecamatan;
  List<Datapenduduk>? datapenduduk;

  Data({this.id, this.kecamatan, this.datapenduduk});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kecamatan = json['kecamatan'];
    if (json['datapenduduk'] != null) {
      datapenduduk = <Datapenduduk>[];
      json['datapenduduk'].forEach((v) {
        datapenduduk!.add(Datapenduduk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kecamatan'] = kecamatan;
    if (datapenduduk != null) {
      data['datapenduduk'] = datapenduduk!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datapenduduk {
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

  Datapenduduk(
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
      this.jenisKelamin});

  Datapenduduk.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
