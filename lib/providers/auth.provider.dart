import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool _error = false;
  String _nombreUsuario = '';
  String _errorText = '';




  String get errorText => _errorText;

  set errorText(String value) {
    _errorText = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get error => _error;

  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  String get nombreUsuario => _nombreUsuario;

  set nombreUsuario(String value) {
    _nombreUsuario = value;
    notifyListeners();
  }

  resetProvider() {
    _loading = false;
    _error = false;
    _nombreUsuario = '';
    notifyListeners();
  }
}
