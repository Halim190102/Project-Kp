import 'package:flutter/material.dart';
import 'package:koperasi/view_model/appbar.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/views/apps_pages/data.dart';
import 'package:koperasi/views/apps_pages/drawer.dart';
import 'package:koperasi/views/component/theme/color.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<KecamatanProvider>(context, listen: false).getKecamatan();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final action = Provider.of<AppbarSearch>(context);
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Data Penduduk'),
        actions: [
          IconButton(
            onPressed: () {
              action.action();
            },
            icon: Icon(action.search == false ? Icons.search : Icons.close),
          ),
        ],
      ),
      backgroundColor: green,
      body: const DataPendudukView(),
    );
  }
}
