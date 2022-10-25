import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:koperasi/routes.dart';
import 'package:koperasi/view_model/image_services.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/views/apps_pages/home.dart';
import 'package:koperasi/views/authentication/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ImageServices(),
          ),
          ChangeNotifierProvider(
            create: (context) => KecamatanProvider(),
          ),
          // ChangeNotifierProvider(
          //   create: (context) => PendudukProvider(),
          // ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: FirebaseAuth.instance.currentUser == null ? LoginPage.id : Home.id,
          onGenerateRoute: MyRouter.generateRoute,
          // home: LoginPage(),
        ),
      ),
    );
  }
}
