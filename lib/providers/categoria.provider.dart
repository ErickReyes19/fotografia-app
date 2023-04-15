import 'package:flutter/material.dart';

import '../models/models.dart';

class CategoriasProvider with ChangeNotifier {
  List<Categoria> _listCategorias = [];
  bool _loading = false;

  
  int _idCategoriaSelected = 0;
  String _nombreCategoriaSelected = 'Seleccione una categoria';

  String get nombreCategoriaSelected => _nombreCategoriaSelected;

  set nombreCategoriaSelected(String value) {
    _nombreCategoriaSelected = value;
    notifyListeners();
  }

  int get idCategoriaSelected => _idCategoriaSelected;

  set idCategoriaSelected(int value) {
    _idCategoriaSelected = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Categoria> get listCategorias => _listCategorias;

  set listCategorias(List<Categoria> value) {
    _listCategorias = value;
    notifyListeners();
  }


  resetProvider() {
    _listCategorias = [];
    _loading = false;
    _nombreCategoriaSelected =  'Seleccione una categoria';
    _idCategoriaSelected = 0;
  }
}
