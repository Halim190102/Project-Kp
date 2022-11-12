import 'package:flutter/material.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<KecamatanProvider>(context, listen: false).getKecamatan();
    });
  }

  @override
  Widget build(BuildContext context) {
    KecamatanProvider viewModel = Provider.of<KecamatanProvider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () {
        return viewModel.getKecamatan();
      },
      child: child(viewModel),
    );
  }

  Widget child(KecamatanProvider viewModel) {
    final isLoading = viewModel.state == ViewState.loading;
    final isError = viewModel.state == ViewState.error;

    if (isLoading && viewModel.kecamatan == null) {
      return const Load();
    }
    if (isError) {
      return const Center(
        child: Text('Gagal memuat data.'),
      );
    }
    return listView(viewModel);
  }

  Widget listView(KecamatanProvider viewModel) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Consumer<KecamatanProvider>(
        builder: (context, value, child) {
          final datas = value.kecamatan;

          return datas != null
              ? ListView.separated(
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
                )
              : const SizedBox();
        },
      ),
    );
  }
}
