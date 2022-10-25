import 'package:flutter/material.dart';
import 'package:koperasi/views/apps_pages/home.dart';
import 'package:koperasi/views/authentication/login.dart';
import 'package:koperasi/views/authentication/register.dart';
import 'package:koperasi/views/component/theme/color.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RegisterPage.id:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case LoginPage.id:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      // case ResetPasswordScreen.id:
      //   return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case Home.id:
        return MaterialPageRoute(builder: (_) => const Home());

      // case VerifyAccountScreen.id:
      //   dynamic args = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => VerifyAccountScreen(
      //             token: args['token'],
      //             uid: args['uid'],
      //           ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: white,
            body: const Center(
              child: Text(
                'Something went wrong',
              ),
            ),
          ),
        );
    }
  }
}
