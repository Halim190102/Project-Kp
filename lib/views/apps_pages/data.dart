import 'package:flutter/material.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/views/apps_pages/data_listView/listview_kecamatan.dart';
import 'package:koperasi/views/component/animation/loading.dart';
import 'package:provider/provider.dart';

class DataPenduduk extends StatefulWidget {
  const DataPenduduk({Key? key}) : super(key: key);

  @override
  State<DataPenduduk> createState() => _DataPendudukState();
}

class _DataPendudukState extends State<DataPenduduk> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Provider.of<KecamatanProvider>(context, listen: false).getKecamatan();
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Consumer<KecamatanProvider>(
          builder: (context, value, child) {
            final datas = value.kecamatan;
            if (datas == null) {
              return const Load();
            } else {
              return ListView.separated(
                itemBuilder: (ctx, i) {
                  final myData = datas.data![i];
                  return ListData(
                    myData: myData,
                  );
                },
                separatorBuilder: (ctx, i) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: datas.data!.length,
              );
            }
          },
        ),
      ),
    );
  }
}
