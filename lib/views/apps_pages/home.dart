import 'package:flutter/material.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/views/apps_pages/akun.dart';
import 'package:koperasi/views/apps_pages/data.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class Home extends StatefulWidget {
  static const String id = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    Provider.of<KecamatanProvider>(context, listen: false).getKecamatan();
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
      backgroundColor: Colors.lightGreenAccent,
      body: SafeArea(
        child: Center(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _listOfWidget,
          ),
        ),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.redAccent,
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        activeColor: const Color(0xFF01579B),
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

List<Widget> _listOfWidget = <Widget>[
  const DataPenduduk(),
  const MyAkun(),
];
