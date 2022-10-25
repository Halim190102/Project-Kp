import 'package:flutter/material.dart';
import 'package:koperasi/views/component/theme/color.dart';

class CustomSnackBar {
  static void showErrorSnackBar(BuildContext context,
      {String? message, int milliseconds = 5000, SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: rawPink,
        behavior: snackBarBehavior,
        action:
            SnackBarAction(textColor: Colors.black, label: 'Tutup', onPressed: () => _dismissCurrentSnackBar(context)),
        duration: Duration(milliseconds: milliseconds),
        content: SelectableText(
          message ?? 'An error occured',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static void _dismissCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
