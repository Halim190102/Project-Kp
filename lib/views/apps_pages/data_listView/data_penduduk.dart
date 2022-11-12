import 'package:flutter/material.dart';
import 'package:koperasi/model/kecamatan_model.dart';

class DialogData extends StatelessWidget {
  const DialogData({Key? key, required this.data}) : super(key: key);
  final Datapenduduk data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.expand_less),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Wrap(
              spacing: 8,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  spacing: 15,
                  children: const [
                    TextWidget(d: 'Nama'),
                    TextWidget(d: 'NIK'),
                    TextWidget(d: 'No. Telp'),
                    TextWidget(d: 'Kel/Desa'),
                    TextWidget(d: 'Alamat'),
                    TextWidget(d: 'Email'),
                    TextWidget(d: 'Tempat, Tgl Lahir'),
                    TextWidget(d: 'Jenis Kelamin'),
                  ],
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 15,
                  children: [
                    TextWidget(d: ': ${data.nama}'),
                    TextWidget(d: ': ${data.nik}'),
                    TextWidget(d: ': ${data.telp}'),
                    TextWidget(d: ': ${data.desaLurah}'),
                    TextWidget(d: ': ${data.alamat}'),
                    TextWidget(d: ': ${data.email}'),
                    TextWidget(d: ': ${data.tempatLahir}, ${data.tanggalLahir}'),
                    TextWidget(d: ': ${data.jenisKelamin}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.d,
  }) : super(key: key);
  final String d;

  @override
  Widget build(BuildContext context) {
    return Text(
      d,
      style: const TextStyle(fontSize: 11.5),
    );
  }
}
