import 'package:flutter/material.dart';
import 'package:koperasi/api/api.dart';
import 'package:koperasi/model/kecamatan_model.dart';

enum ViewState {
  none,
  loading,
  error,
}

class KecamatanProvider with ChangeNotifier {
  DataKecamatanModel? kecamatan;

  ViewState _state = ViewState.none;
  ViewState get state => _state;

  changeState(ViewState s) {
    _state = s;
    notifyListeners();
  }

  getKecamatan() async {
    changeState(ViewState.loading);
    try {
      kecamatan = await Api().getKecamatan();
      notifyListeners();
    } catch (e) {
      changeState(ViewState.error);
    }
  }
}
