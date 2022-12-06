import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koperasi/view_model/authentication/auth.dart';
import 'package:koperasi/views/authentication/login.dart';
// import 'package:vaccine_booking_system/Views/Screens/home.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    FireAuth.sendVerify();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        if (!mounted) return;
        FireAuth.logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Email not verified',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red),
            ),
            const SizedBox(
              height: 15,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
