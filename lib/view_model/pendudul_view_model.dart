import 'package:flutter/material.dart';
import 'package:koperasi/api/api.dart';

class PendudukProvider with ChangeNotifier {
  Future addData(
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
    await Api().addDataPenduduk(
      kecId,
      nama,
      nik,
      telp,
      desaLurah,
      alamat,
      email,
      tempat,
      tanggal,
      gender,
    );
    notifyListeners();
  }
}