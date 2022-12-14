import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/utils/validator.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/view_model/pendudul_view_model.dart';
import 'package:koperasi/views/component/form/textfield_component.dart';
import 'package:koperasi/views/component/snackbar/snackbar.dart';
import 'package:koperasi/views/component/theme/color.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  const AddData({
    Key? key,
    required this.init,
    this.idKec,
    this.penduduk,
  }) : super(key: key);
  final Datapenduduk? penduduk;
  final int? idKec;
  final bool init;

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _key = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nikController = TextEditingController();
  final _telpController = TextEditingController();
  final _desalurahController = TextEditingController();
  final _alamatController = TextEditingController();
  final _emailController = TextEditingController();
  final _tempatController = TextEditingController();
  final _tglController = TextEditingController();
  final _genderController = TextEditingController();

  int? idPenduduk;
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    final d = widget.penduduk;
    if (d != null) {
      idPenduduk = d.id;
      _namaController.text = d.nama!;
      _nikController.text = d.nik!;
      _telpController.text = d.telp!;
      _desalurahController.text = d.desaLurah!;
      _alamatController.text = d.alamat!;
      _emailController.text = d.email!;
      _tempatController.text = d.tempatLahir!;
      _tglController.text = d.tanggalLahir!;
      _genderController.text = d.jenisKelamin!;
      _isUpdate = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _namaController.dispose();
    _nikController.dispose();
    _telpController.dispose();
    _desalurahController.dispose();
    _alamatController.dispose();
    _emailController.dispose();
    _tempatController.dispose();
    _tglController.dispose();
    _genderController.dispose();
  }

  final currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '');
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        centerTitle: true,
        backgroundColor: red,
        title: Text(widget.init ? 'Tambah Data' : 'Edit Data'),
        actions: [
          IconButton(
            icon: Icon(widget.init ? Icons.add : Icons.save),
            onPressed: () async {
              final d = widget.penduduk;

              final nama = _namaController.text;
              final nik = _nikController.text;
              final telp = _telpController.text;
              final desaLurah = _desalurahController.text;
              final alamat = _alamatController.text;
              final email = _emailController.text;
              final tempat = _tempatController.text;
              final tanggal = _tglController.text;
              final gender = _genderController.text;
              final kec = Provider.of<KecamatanProvider>(context, listen: false);
              final data = Provider.of<PendudukProvider>(context, listen: false);
              FocusManager.instance.primaryFocus?.unfocus();

              if (_key.currentState!.validate()) {
                if (!_isUpdate) {
                  await data
                      .addData(widget.idKec!, nama, nik, telp, desaLurah, alamat, email, tempat, tanggal, gender)
                      .then(
                        (value) => kec.getKecamatan(),
                      )
                      .then((value) => Navigator.pop(context));
                } else {
                  final condition = nama != d!.nama! ||
                      nik != d.nik! ||
                      telp != d.telp! ||
                      desaLurah != d.desaLurah! ||
                      alamat != d.alamat! ||
                      email != d.email! ||
                      tempat != d.tempatLahir! ||
                      tanggal != d.tanggalLahir! ||
                      gender != d.jenisKelamin!;
                  if (condition) {
                    await data
                        .editData(
                            d.id!, d.kecamatanId!, nama, nik, telp, desaLurah, alamat, email, tempat, tanggal, gender)
                        .then(
                          (value) => kec.getKecamatan(),
                        )
                        .then((value) => Navigator.pop(context, nama != widget.penduduk!.nama! ? nama : ''));
                  } else {
                    CustomSnackBar.showErrorSnackBar(
                      context,
                      message: 'Tidak ada yang berubah !!',
                    );
                    Future.delayed(const Duration(milliseconds: 2900), () {
                      Navigator.pop(context, '');
                    });
                  }
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _key,
            child: Column(
              children: [
                FormCom(
                  controller: _namaController,
                  label: 'Nama',
                  valid: (e) => Validator.validateNama(e),
                  icon: false,
                  obscure: false,
                  textCapitalization: TextCapitalization.sentences,
                ),
                FormCom(
                  controller: _nikController,
                  label: 'NIK',
                  valid: (e) => Validator.validateNIK(e),
                  icon: false,
                  obscure: false,
                  textCapitalization: TextCapitalization.none,
                  type: TextInputType.number,
                  format: [FilteringTextInputFormatter.digitsOnly],
                ),
                FormCom(
                  controller: _telpController,
                  label: 'No. Telepon',
                  valid: (e) {
                    if (e!.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    }
                    return null;
                  },
                  icon: false,
                  obscure: false,
                  textCapitalization: TextCapitalization.none,
                  type: TextInputType.number,
                  format: [FilteringTextInputFormatter.digitsOnly],
                ),
                FormCom(
                  controller: _desalurahController,
                  label: 'Desa/Lurah',
                  valid: (e) {
                    if (e!.isEmpty) {
                      return 'Desa/Lurah tidak boleh kosong';
                    }
                    return null;
                  },
                  icon: false,
                  obscure: false,
                  textCapitalization: TextCapitalization.none,
                ),
                FormCom(
                  controller: _alamatController,
                  label: 'Alamat',
                  valid: (e) {
                    if (e!.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                  icon: false,
                  obscure: false,
                  textCapitalization: TextCapitalization.none,
                ),
                FormCom(
                  controller: _emailController,
                  label: 'Email',
                  valid: (e) => Validator.validateEmail(e),
                  icon: false,
                  obscure: false,
                  textCapitalization: TextCapitalization.none,
                ),
                FormCom(
                  controller: _tempatController,
                  label: 'Tempat Lahir',
                  valid: (e) {
                    if (e!.isEmpty) {
                      return 'Tempat lahir tidak boleh kosong';
                    }
                    return null;
                  },
                  icon: false,
                  obscure: false,
                  textCapitalization: TextCapitalization.none,
                ),
                FormComDate(
                  controller: _tglController,
                  label: 'Tanggal Lahir',
                  onTap: () async {
                    final selectDate = await datePick(context);
                    setState(() {
                      if (selectDate != null) {
                        _tglController.text = DateFormat('dd-MM-yyyy').format(selectDate);
                      }
                    });
                  },
                ),
                FormComDropdown(
                  label: 'Jenis Kelamin',
                  data: (e) {
                    setState(() {
                      _genderController.text = e!;
                    });
                  },
                  value: _genderController.text,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> datePick(BuildContext context) {
    return showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.amberAccent,
              onPrimary: Colors.redAccent,
              onSurface: Colors.blueAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1940),
      lastDate: DateTime(2050),
    );
  }
}
