import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/view_model/pendudul_view_model.dart';
import 'package:koperasi/views/apps_pages/data_listView/add_data.dart';
import 'package:koperasi/views/apps_pages/data_listView/data_penduduk.dart';
import 'package:koperasi/views/apps_pages/data_listView/dialog_delete.dart';
import 'package:koperasi/views/component/iconButton/iconbuttonservice.dart';
import 'package:koperasi/views/component/theme/color.dart';
import 'package:provider/provider.dart';

class ListPenduduk extends StatefulWidget {
  const ListPenduduk({
    Key? key,
    required this.d,
    required this.dLength,
  }) : super(key: key);

  final List<Datapenduduk> d;
  final int dLength;

  @override
  State<ListPenduduk> createState() => _ListPendudukState();
}

class _ListPendudukState extends State<ListPenduduk> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 100,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (ctx, i) {
          final penduduk = widget.d[i];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${i + 1}. ${penduduk.nama!}',
                style: text,
              ),
              Wrap(
                spacing: 5,
                children: [
                  ButtonServices(
                    icon: Icons.menu_open,
                    color: Colors.black,
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => DialogData(data: penduduk),
                      );
                    },
                  ),
                  ButtonServices(
                    icon: Icons.edit,
                    color: Colors.amber,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddData(
                            penduduk: penduduk,
                            init: false,
                          ),
                        ),
                      );
                    },
                  ),
                  ButtonServices(
                    icon: CupertinoIcons.clear_circled_solid,
                    color: Colors.red,
                    onTap: () async {
                      final data = Provider.of<PendudukProvider>(context, listen: false);
                      await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => AlertDialogWidget(data: data, dataPen: penduduk));
                    },
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (ctx, i) {
          return const SizedBox(
            height: 12,
          );
        },
        itemCount: widget.dLength,
      ),
    );
  }
}
