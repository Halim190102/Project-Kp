import 'package:flutter/material.dart';
import 'package:koperasi/utils/loader.dart';
import 'package:koperasi/view_model/authentication/auth.dart';
import 'package:koperasi/utils/validator.dart';
import 'package:koperasi/view_model/authentication/firebase_exceptions.dart';
import 'package:koperasi/views/apps_pages/home.dart';
import 'package:koperasi/views/authentication/register.dart';
import 'package:koperasi/views/authentication/reset.dart';
import 'package:koperasi/views/component/form/button_component.dart';
import 'package:koperasi/views/component/form/text_component.dart';
import 'package:koperasi/views/component/form/textfield_component.dart';
import 'package:koperasi/views/component/snackbar/snackbar.dart';
import 'package:koperasi/views/component/theme/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void clear() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.03),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 1,
                      child: Image.asset(
                        'assets/component/login.jpg',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormCom(
                          controller: _emailController,
                          label: 'Email',
                          valid: (e) => Validator.validateEmail(e),
                          icon: false,
                          obscure: false,
                          textCapitalization: TextCapitalization.none,
                        ),
                        FormCom(
                          controller: _passwordController,
                          label: 'Password',
                          valid: (e) => Validator.validatePassLog(e),
                          icon: true,
                          obscure: true,
                          textCapitalization: TextCapitalization.none,
                        ),
                        ButtonCom(
                          color: red,
                          icon: Icons.arrow_forward_ios,
                          text: 'Login',
                          onTap: () async {
                            String email = _emailController.text.trim();
                            String pass = _passwordController.text;
                            if (_key.currentState!.validate()) {
                              LoaderX.show(context);
                              final status = await FireAuth.login(email: email, pass: pass);
                              if (status == AuthStatus.successful) {
                                LoaderX.hide();
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const Home(),
                                  ),
                                );
                              } else {
                                LoaderX.hide();
                                final error = AuthExceptionHandler.generateErrorMessage(status);
                                if (!mounted) return;
                                CustomSnackBar.showErrorSnackBar(
                                  context,
                                  message: error,
                                );
                              }
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCom(
                              text1: 'Daftar',
                              onTap: () {
                                clear();
                                Future.delayed(
                                  Duration.zero,
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      maintainState: false,
                                      builder: (_) => const RegisterPage(),
                                    ),
                                  ),
                                );
                              },
                              color: blue,
                            ),
                            // TextCom(
                            //   onTap: () => showDialog(
                            //     context: context,
                            //     builder: (_) => const ResetPass(),
                            //   ),
                            //   text1: 'Lupa Password',
                            //   color: orange,
                            // )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
