import 'package:flutter/material.dart';
import 'package:koperasi/api/api.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/model/penduduk_model.dart';

class KecamatanProvider with ChangeNotifier {
  DataKecamatanModel? kecamatan;
  DataPendudulModel? penduduks;

  getKecamatan() async {
    kecamatan = await Api().getKecamatan();
    penduduks = await Api().getPenduduk();

    notifyListeners();
  }
}
