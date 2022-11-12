import 'package:flutter/material.dart';
import 'package:koperasi/views/apps_pages/akun.dart';
import 'package:koperasi/views/apps_pages/data.dart';
import 'package:koperasi/views/component/theme/color.dart';
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

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     await Provider.of<KecamatanProvider>(context, listen: false).getKecamatan();
  //   });
  // }

  @override
  void initState() {
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

List<Widget> _listOfWidget = <Widget>[
  const DataPendudukView(),
  // const Text('halo'),
  const MyAkun(),
];


// class Home extends StatefulWidget {
//   static const String id = 'home';
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int selectedIndex = 0;
//   late PageController _pageController;
//   bool? check;

//   initCheck() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         setState(() {
//           check = true;
//         });
//       }
//     } on SocketException catch (_) {
//       setState(() {
//         check = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(const Duration(microseconds: 1), (timer) {
//       initCheck();
//     });
//     _pageController = PageController(initialPage: selectedIndex);
//   }

//   void onButtonPressed(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//     _pageController.animateToPage(selectedIndex,
//         duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (check == false) {
//       return WidgetCheck(
//         data: onButtonPressed,
//         page: _pageController,
//         index: selectedIndex,
//         widget: _listOfWidgetOffline,
//       );
//     }
//     return WidgetCheck(
//       data: onButtonPressed,
//       page: _pageController,
//       index: selectedIndex,
//       widget: _listOfWidget,
//     );
//   }
// }

// List<Widget> _listOfWidget = <Widget>[
//   const DataPenduduk(),
//   const MyAkun(),
// ];

// List<Widget> _listOfWidgetOffline = <Widget>[
//   const Text('anda Offline'),
//   const Text('anda Offline'),
// ];

// class WidgetCheck extends StatefulWidget {
//   const WidgetCheck({Key? key, required this.data, required this.page, required this.index, required this.widget})
//       : super(key: key);
//   final void Function(int) data;
//   final PageController page;
//   final int index;
//   final List<Widget> widget;

//   @override
//   State<WidgetCheck> createState() => _WidgetCheckState();
// }

// class _WidgetCheckState extends State<WidgetCheck> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightGreenAccent,
//       body: SafeArea(
//         child: Center(
//           child: PageView(
//             physics: const NeverScrollableScrollPhysics(),
//             controller: widget.page,
//             children: widget.widget,
//           ),
//         ),
//       ),
//       bottomNavigationBar: SlidingClippedNavBar(
//         backgroundColor: Colors.redAccent,
//         onButtonPressed: widget.data,
//         iconSize: 30,
//         activeColor: const Color(0xFF01579B),
//         selectedIndex: widget.index,
//         barItems: <BarItem>[
//           BarItem(
//             icon: Icons.home,
//             title: 'Home',
//           ),
//           BarItem(
//             icon: Icons.account_circle,
//             title: 'Akun',
//           ),
//         ],
//       ),
//     );
//   }
// }