import 'package:flutter/material.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/model/penduduk_model.dart';
import 'package:koperasi/view_model/appbar.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/view_model/pendudul_view_model.dart';
import 'package:koperasi/views/apps_pages/data_listView/add_data.dart';
import 'package:koperasi/views/apps_pages/data_listView/data_penduduk.dart';
import 'package:koperasi/views/apps_pages/data_listView/dialog_delete.dart';
import 'package:koperasi/views/apps_pages/data_listView/listview_kecamatan.dart';
import 'package:koperasi/views/component/animation/loading.dart';
import 'package:koperasi/views/component/theme/color.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DataPendudukView extends StatefulWidget {
  const DataPendudukView({Key? key}) : super(key: key);

  @override
  State<DataPendudukView> createState() => _DataPendudukViewState();
}

class _DataPendudukViewState extends State<DataPendudukView> {
  final _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppbarSearch action = Provider.of<AppbarSearch>(context);
    if (action.search == false) {
      _searchController.clear();
      items.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  var items = <String>[];

  @override
  Widget build(BuildContext context) {
    // AppbarSearch action = Provider.of<AppbarSearch>(context);

    return Consumer<KecamatanProvider>(
      builder: (context, value, child) {
        final data1 = value.kecamatan;
        final data2 = value.penduduks;
        if (data1 != null && data2 != null) {
          final dataPenduduks = data2.data!.map((e) => e.nama!).toList();
          return RefreshIndicator(
            onRefresh: () {
              return value.getKecamatan();
            },
            child: dataConsumer(dataPenduduks, data1, data2),
          );
        }
        return const Loading();
      },
    );
  }

  Widget dataConsumer(List<String> dataPenduduks, DataKecamatanModel data1, DataPendudulModel data2) {
    return Consumer<AppbarSearch>(
      builder: (context, action, child) {
        if (action.search == true) {
          return Container(
            color: Colors.white54,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Cari Nama...'),
                    controller: _searchController,
                    onChanged: (query) {
                      if (query.isNotEmpty) {
                        List<String> dummyListData = <String>[];
                        for (var item in dataPenduduks) {
                          if (item.toLowerCase().contains(query.toLowerCase())) {
                            dummyListData.add(item);
                          }
                        }
                        setState(() {
                          items.clear();
                          items.addAll(dummyListData);
                        });
                        return;
                      } else {
                        setState(() {
                          items.clear();
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final kec = data1.data!
                          .firstWhere(
                            (ele) =>
                                ele.id == data2.data!.firstWhere((element) => element.nama == items[i]).kecamatanId,
                          )
                          .kecamatan;
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            items[i],
                            style: text,
                          ),
                          subtitle: Text(
                            'Kecamatan ${kec!}',
                            style: text,
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem<int>(
                                  value: 0,
                                  child: Text("Details"),
                                ),
                                const PopupMenuItem<int>(
                                  value: 1,
                                  child: Text("Edit"),
                                ),
                                const PopupMenuItem<int>(
                                  value: 2,
                                  child: Text("Hapus"),
                                ),
                              ];
                            },
                            onSelected: (value) async {
                              final dataKec =
                                  data1.data!.firstWhere((element) => element.kecamatan == kec).datapenduduk!;
                              final dataPen = dataKec.firstWhere((element) => element.nama == items[i]);
                              switch (value) {
                                case 0:
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) {
                                      return DialogData(
                                        data: dataPen,
                                      );
                                    },
                                  );
                                  break;
                                case 1:
                                  String edit = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddData(
                                        penduduk: dataPen,
                                        init: false,
                                      ),
                                    ),
                                  );
                                  if (edit.isNotEmpty) {
                                    items[i] = edit;
                                  }
                                  break;
                                case 2:
                                  final data = Provider.of<PendudukProvider>(context, listen: false);
                                  bool dialog = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => AlertDialogWidget(data: data, dataPen: dataPen),
                                  );

                                  if (dialog == true) {
                                    items.removeWhere((a) => a == items[i]);
                                  }
                                  break;
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (ctx, i) {
              final myData = data1.data![i];

              return ListData(
                myData: myData,
              );
            },
            separatorBuilder: (ctx, i) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: data1.data!.length,
          ),
        );
      },
    );
  }
}
