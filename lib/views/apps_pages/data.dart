import 'package:flutter/material.dart';
import 'package:koperasi/model/kecamatan_model.dart';
import 'package:koperasi/model/penduduk_model.dart';
import 'package:koperasi/view_model/appbar.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/views/apps_pages/data_listView/listview_kecamatan.dart';
import 'package:koperasi/views/component/animation/loading.dart';
import 'package:provider/provider.dart';

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

  List<String>? dataPenduduks;
  var items = <String>[];

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      for (var item in dataPenduduks!) {
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
  }

  @override
  Widget build(BuildContext context) {
    AppbarSearch action = Provider.of<AppbarSearch>(context);

    return Consumer<KecamatanProvider>(
      builder: (context, value, child) {
        final data1 = value.kecamatan;
        final data2 = value.penduduks;
        if (data1 != null && data2 != null) {
          dataPenduduks = data2.data!.map((e) => e.nama!).toList();
          return RefreshIndicator(
            onRefresh: () {
              return value.getKecamatan();
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: action.search == true
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              filterSearchResults(value);
                            },
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, i) {
                                final kec = data1.data!
                                    .firstWhere(
                                      (ele) =>
                                          ele.id ==
                                          data2.data!.firstWhere((element) => element.nama == items[i]).kecamatanId,
                                    )
                                    .kecamatan;
                                return ListTile(
                                  title: Text(items[i]),
                                  trailing: Text(kec!),
                                );
                              },
                            ),
                          ),
                        ],
                      ))
                  : ListView.separated(
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
            ),
          );
        }
        return const Loading();
      },
    );
  }
}
