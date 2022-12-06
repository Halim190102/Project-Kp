import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:koperasi/view_model/appbar.dart';
import 'package:koperasi/view_model/image_services.dart';
import 'package:koperasi/view_model/kecamatan_view_model.dart';
import 'package:koperasi/view_model/pendudul_view_model.dart';
import 'package:koperasi/views/apps_pages/home.dart';
import 'package:koperasi/views/authentication/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyDzjWVN7rSmibMBN9jNGkBsXC5DVMvm1zE",
      //   authDomain: "kp-2022.firebaseapp.com",
      //   databaseURL: "https://kp-2022-default-rtdb.firebaseio.com",
      //   projectId: "kp-2022",
      //   storageBucket: "kp-2022.appspot.com",
      //   messagingSenderId: "927527145471",
      //   appId: "1:927527145471:web:de47a1e63e3fcb7e3761ca",
      //   measurementId: "G-79XK4F4JG1",
      // ),
      );
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
          ChangeNotifierProvider(
            create: (context) => PendudukProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AppbarSearch(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser == null ? const LoginPage() : const Home(),
        ),
      ),
    );
  }
}
