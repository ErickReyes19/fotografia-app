import 'package:flutter/material.dart';

import '../models/models.dart';

class ServiciosProvider with ChangeNotifier {
  List<Servicio> _listServicios = [];
  bool _loading = false;
  int _idServicio = 0;

  int _idServicioSelected = 0;
  String _nombreServicioSelected = 'Seleccione un servicio';

  String get nombreServicioSelected => _nombreServicioSelected;

  set nombreServicioSelected(String value) {
    _nombreServicioSelected = value;
    notifyListeners();
  }

  int get idServicioSelected => _idServicioSelected;

  set idServicioSelected(int value) {
    _idServicioSelected = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int get idServicio => _idServicio;

  set idServicio(int value) {
    _idServicio = value;
    notifyListeners();
  }

  List<Servicio> get listServicios => _listServicios;

  set listServicios(List<Servicio> value) {
    _listServicios = value;
    notifyListeners();
  }

  resetProvider() {
    _listServicios = [];
    _loading = false;
  }
}
