import 'package:dio/dio.dart';
import 'package:koperasi/model/kecamatan_model.dart';

class Api {
  final url = 'http://10.0.2.2:8000/api';

  getKecamatan() async {
    Response response = await Dio().get('$url/kecamatan');
    return DataKecamatanModel.fromJson(response.data);
  }

  // getPenduduk() async {
  //   Response response = await Dio().get('$url/data');
  //   return DataPendudukModel.fromJson(response.data);
  // }
  addDataPenduduk(
    int kecId,
    String nama,
    String nik,
    String telp,
    String desaLurah,
    String alamat,
    String email,
    String tempat,
    String tanggal,
    String gender,
  ) async {
    await Dio().post('$url/data', data: {
      'kecamatan_id': kecId,
      'nama': nama,
      "nik": nik,
      "telp": telp,
      "desa_lurah": desaLurah,
      "alamat": alamat,
      "email": email,
      "tempat_lahir": tempat,
      "tanggal_lahir": tanggal,
      "jenis_kelamin": gender,
    });
  }
}
