import 'package:flutter/material.dart';
import 'package:koperasi/utils/loader.dart';
import 'package:koperasi/utils/validator.dart';
import 'package:koperasi/view_model/authentication/auth.dart';
import 'package:koperasi/view_model/authentication/firebase_exceptions.dart';
import 'package:koperasi/views/authentication/login.dart';
import 'package:koperasi/views/component/form/button_component.dart';
import 'package:koperasi/views/component/form/textfield_component.dart';
import 'package:koperasi/views/component/snackbar/snackbar.dart';
import 'package:koperasi/views/component/theme/color.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              FormCom(
                controller: _emailController,
                label: 'Email',
                valid: (e) => Validator.validateEmail(e),
                icon: false,
                obscure: false,
                textCapitalization: TextCapitalization.none,
              ),
              ButtonCom(
                color: green,
                icon: Icons.send,
                text: 'Reset',
                onTap: () async {
                  String email = _emailController.text.trim();
                  if (_key.currentState!.validate()) {
                    LoaderX.show(context);
                    final status = await FireAuth.reset(email: email);
                    if (status == AuthStatus.successful) {
                      LoaderX.hide();
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
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
            ],
          ),
        ),
      ),
    );
  }
}
