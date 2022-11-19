import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  bool isChechBoxOkey = false;

  String? _inputText;
  bool isLoading = false;

  void chechBoxChange(bool value) {
    isChechBoxOkey = value;
    notifyListeners();
  }

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<bool> controlTextValue() async {
    _changeLoading();
    await Future.delayed(Duration(seconds: 1));
    _changeLoading();
    return _inputText != null;
  }
}
