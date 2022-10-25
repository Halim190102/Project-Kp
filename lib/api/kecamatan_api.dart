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
}
