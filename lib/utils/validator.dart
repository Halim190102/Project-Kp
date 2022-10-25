import 'package:email_validator/email_validator.dart';

class Validator {
  static validateNama(String? e) {
    if (e!.isEmpty) {
      return 'Nama Tidak Boleh Kosng';
    } else if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(e)) {
      return 'Masukkan Nama Yang Valid';
    }
    return null;
  }

  static validateEmail(String? e) {
    if (e!.isEmpty) {
      return 'Email Tidak Boleh Kosong';
    } else if (!EmailValidator.validate(e)) {
      return 'Masukkan format yang sesuai';
    }
    return null;
  }

  static validateNIK(String? e) {
    if (e!.isEmpty) {
      return 'Nomor Tidak Boleh Kosong';
    } else if (e.length != 16) {
      return 'NIK harus 16 Karakter';
    }
    return null;
  }

  static validatePassLog(String? e) {
    if (e!.isEmpty) {
      return 'Password Tidak Boleh Kosong';
    }
    return null;
  }

  static validatePass(String? e) {
    if (e!.isEmpty) {
      return 'Password Tidak Boleh Kosong';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(e)) {
      return 'Masukkan minimal 1 Huruf Besar';
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(e)) {
      return 'Masukkan minimal 1 Huruf Kecil';
    } else if (!RegExp(r'(?=.*[0-9])').hasMatch(e)) {
      return 'Masukkan minimal 1 Angka';
    } else if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(e)) {
      return 'Masukkan minimal 1 Karakter Spesial';
    } else if (e.length < 6) {
      return 'Masukkan Minimal 6 Karakter';
    }
    return null;
  }

  static validatePassReplay(String? e, String? a) {
    if (e!.isEmpty) {
      return 'Password Tidak Boleh Kosong';
    } else if (a != e) {
      return 'Password harus sama';
    }
    return null;
  }
}
