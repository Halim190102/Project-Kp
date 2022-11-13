import 'package:flutter/material.dart';
import 'package:koperasi/views/apps_pages/data_listView/add_data.dart';

class ListKecamatan extends StatelessWidget {
  const ListKecamatan({
    Key? key,
    required this.kecamatans,
    this.id,
  }) : super(key: key);

  final String? kecamatans;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Kecamatan ${kecamatans!}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Rob',
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddData(
                    idKec: id,
                    init: true,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_rounded,
              color: Colors.blueGrey,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
