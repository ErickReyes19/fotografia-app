import 'package:flutter/material.dart';

import '../models/models.dart';

class LocalesProvider with ChangeNotifier {
  List<Locale> _listLocales = [];
  bool _loading = false;

  int _idLocalSelected = 0;
  String _nombreLocalSelected = 'Seleccione un local';

  String get nombreLocalSelected => _nombreLocalSelected;

  set nombreLocalSelected(String value) {
    _nombreLocalSelected = value;
    notifyListeners();
  }

  int get idServicioSelected => _idLocalSelected;

  set idServicioSelected(int value) {
    _idLocalSelected = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Locale> get listLocales => _listLocales;

  set listLocales(List<Locale> value) {
    _listLocales = value;
    notifyListeners();
  }

  resetProvider() {
    _listLocales = [];
    _loading = false;
  }
}
