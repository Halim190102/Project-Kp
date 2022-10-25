import 'package:flutter/material.dart';
import 'package:koperasi/api/kecamatan_api.dart';
import 'package:koperasi/model/kecamatan_model.dart';

class KecamatanProvider with ChangeNotifier {
  final Api api = Api();
  DataKecamatanModel? kecamatan;

  Future getKecamatan() async {
    kecamatan = await api.getKecamatan();
    notifyListeners();
  }
}
