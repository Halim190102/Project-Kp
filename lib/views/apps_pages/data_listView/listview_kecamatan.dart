import 'package:flutter/material.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/views/apps_pages/data_listView/list_kecamatan.dart';
import 'package:koperasi/views/apps_pages/data_listView/list_penduduk.dart';

class ListData extends StatefulWidget {
  const ListData({
    Key? key,
    required this.myData,
  }) : super(key: key);

  final Data myData;

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  bool bool1 = false;
  @override
  Widget build(BuildContext context) {
    final data = widget.myData;
    final d = data.datapenduduk!;
    final dLength = d.length;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListKecamatan(kecamatans: widget.myData.kecamatan),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(150),
            ),
            height: 2.5,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$dLength Data'),
              SizedBox(
                width: 42,
                height: 30,
                child: IconButton(
                  iconSize: 18,
                  onPressed: () {
                    setState(() {
                      bool1 = !bool1;
                    });
                  },
                  icon: bool1 & d.isNotEmpty
                      ? const Icon(
                          Icons.arrow_drop_up,
                        )
                      : const Icon(
                          Icons.arrow_drop_down,
                        ),
                ),
              ),
            ],
          ),
          bool1 & d.isNotEmpty ? ListPenduduk(d: d, dLength: dLength) : const SizedBox(),
        ],
      ),
    );
  }
}
