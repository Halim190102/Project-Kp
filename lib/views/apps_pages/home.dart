import 'package:flutter/material.dart';
import 'package:koperasi/view_model/authentication/auth.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/views/apps_pages/akun.dart';
import 'package:koperasi/views/apps_pages/data.dart';
import 'package:koperasi/views/component/theme/color.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class Home extends StatefulWidget {
  static const String id = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late PageController _pageController;
  String? imgData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<KecamatanProvider>(context, listen: false).getKecamatan();
    });
  }

  @override
  void initState() {
    setState(() {
      imgData = FireAuth.auth.currentUser!.photoURL!;
    });
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: SafeArea(
        child: Center(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              const DataPendudukView(),
              MyAkun(
                imgData: imgData!,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: orangebright,
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        activeColor: blues,
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.account_circle,
            title: 'Akun',
          ),
        ],
      ),
    );
  }
}
