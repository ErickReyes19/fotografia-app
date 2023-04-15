import 'package:flutter/material.dart';

import '../models/models.dart';

class PaqueteProvider with ChangeNotifier {
  List<Paquete> _listPaquete = [];
  bool _loading = false;

  bool get loading => _loading;

  int _idPaqueteSelected = 0;

  DateTime _tiempoCobeturaSelected = DateTime.now();

  String _nombrePaqueteSelected = 'Seleccione un paquete';

  TextEditingController txtTiempoCobertura = TextEditingController( text: '00:00');

  set cambiardireccionClienteController(String value) {
    txtTiempoCobertura.text = value;
    notifyListeners();
  }

  String get nombrePaqueteSelected => _nombrePaqueteSelected;

  set nombrePaqueteSelected(String value) {
    _nombrePaqueteSelected = value;
    notifyListeners();
  }

  int get idPaqueteSelected => _idPaqueteSelected;

  set idPaqueteSelected(int value) {
    _idPaqueteSelected = value;
    notifyListeners();
  }

  DateTime get tiempoCobeturaSelected => _tiempoCobeturaSelected;

  set tiempoCobeturaSelected(DateTime value) {
    _tiempoCobeturaSelected = value;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Paquete> get listPaquete => _listPaquete;

  set listPaquete(List<Paquete> value) {
    _listPaquete = value;
    notifyListeners();
  }

  resetProvider() {
    _listPaquete = [];
    _loading = false;
  }
}
