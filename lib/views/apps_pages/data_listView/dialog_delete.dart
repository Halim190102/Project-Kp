import 'package:flutter/material.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/view_model/pendudul_view_model.dart';
import 'package:koperasi/views/component/theme/color.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertDialogWidget extends StatefulWidget {
  const AlertDialogWidget({
    Key? key,
    required this.data,
    required this.dataPen,
  }) : super(key: key);

  final PendudukProvider data;
  final Datapenduduk dataPen;

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hapus data ?'),
      content: const Text('Data yang dihapus tidak dapat dikembalikan'),
      actions: [
        DialogButton(
          color: green,
          child: const Text('No'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        DialogButton(
          color: orange,
          child: const Text('Yes'),
          onPressed: () async {
            final kec = Provider.of<KecamatanProvider>(context, listen: false);
            await widget.data.deleteData(widget.dataPen.id!).then(
                  (_) => kec.getKecamatan(),
                );
            Future.delayed(Duration.zero, () => Navigator.pop(context, true));
          },
        ),
      ],
    );
  }
}
