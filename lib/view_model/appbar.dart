import 'package:flutter/material.dart';

class AppbarSearch with ChangeNotifier {
  bool _search = false;
  bool get search => _search;

  Function() _onTap = () {};
  Function() get onTap => _onTap;

  action() {
    _search = !_search;
    notifyListeners();
  }

  onTapFunction(Function() f) {
    _onTap = f;
  }
}
