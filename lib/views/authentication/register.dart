import 'package:flutter/material.dart';
import 'package:koperasi/utils/loader.dart';
import 'package:koperasi/view_model/authentication/auth.dart';
import 'package:koperasi/utils/validator.dart';
import 'package:koperasi/view_model/authentication/firebase_exceptions.dart';
import 'package:koperasi/views/authentication/login.dart';
import 'package:koperasi/views/authentication/verify.dart';
import 'package:koperasi/views/component/form/button_component.dart';
import 'package:koperasi/views/component/form/text_component.dart';
import 'package:koperasi/views/component/form/textfield_component.dart';
import 'package:koperasi/views/component/snackbar/snackbar.dart';
import 'package:koperasi/views/component/theme/color.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register_page';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nikController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
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
              child: Form(
                key: _key,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () => Navigator.pushReplacementNamed(context, LoginPage.id),
                        child: const Icon(
                          Icons.close,
                          size: 34,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
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
                                controller: _nameController,
                                label: 'Nama',
                                textCapitalization: TextCapitalization.sentences,
                                valid: (e) => Validator.validateNama(e),
                                icon: false,
                                obscure: false,
                              ),
                              FormCom(
                                controller: _emailController,
                                label: 'Email',
                                valid: (e) => Validator.validateEmail(e),
                                icon: false,
                                obscure: false,
                                textCapitalization: TextCapitalization.none,
                              ),
                              FormCom(
                                controller: _nikController,
                                label: 'Masukkan NIK',
                                valid: (e) => Validator.validateNIK(e),
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
                                icon: Icons.arrow_back_ios_new,
                                text: 'Register',
                                onTap: () async {
                                  String nama = _nameController.text;
                                  // String nik = _nikController.text;
                                  String email = _emailController.text.trim();
                                  String pass = _passwordController.text;
                                  if (_key.currentState!.validate()) {
                                    LoaderX.show(context);

                                    final status = await FireAuth.regis(email: email, pass: pass, nama: nama);
                                    if (status == AuthStatus.successful) {
                                      LoaderX.hide();
                                      if (!mounted) return;
                                      showDialog(
                                        context: context,
                                        builder: (_) => const Verify(),
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
                                children: [
                                  TextCom(
                                    text1: 'Login',
                                    onTap: () => Navigator.pushReplacementNamed(context, LoginPage.id),
                                    color: blue,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
