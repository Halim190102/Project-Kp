import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/views/component/iconButton/iconbuttonservice.dart';

class ListPenduduk extends StatelessWidget {
  const ListPenduduk({
    Key? key,
    required this.d,
    required this.dLength,
  }) : super(key: key);

  final List<Datapenduduk> d;
  final int dLength;

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
          final penduduk = d[i];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${i + 1}. ${penduduk.nama!}',
                style: const TextStyle(
                  fontSize: 11.5,
                ),
              ),
              Wrap(
                spacing: 5,
                children: [
                  ButtonServices(
                    icon: Icons.menu_open,
                    color: Colors.black,
                    onTap: () {},
                  ),
                  ButtonServices(
                    icon: Icons.edit,
                    color: Colors.amber,
                    onTap: () {},
                  ),
                  ButtonServices(
                    icon: CupertinoIcons.clear_circled_solid,
                    color: Colors.red,
                    onTap: () {},
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
        itemCount: dLength,
      ),
    );
  }
}
