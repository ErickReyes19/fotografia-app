import 'package:flutter/material.dart';

import 'package:fotografia_app/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/models.dart';

List<DropdownMenuItem<int>> listaItem(List<Categoria> categoria) {
  List<DropdownMenuItem<int>> lista = [];
  for (var i = 0; i < categoria.length; i++) {
    lista.add(DropdownMenuItem(
      value: categoria[i].idCategoria,
      child: Text(categoria[i].tipoCategoria),
    ));
  }

  return lista;
}

String buscarNombre(List<Categoria> listCategoria, int idSeleccionado) {
  for (var categoria in listCategoria) {
    if (categoria.idCategoria == idSeleccionado) {
      return categoria.tipoCategoria;
    }
  }
  return '';
}

Widget dropDownCategoria(
    List<Categoria> categoria, CategoriasProvider categoriaProvider, context) {
  final tema = Theme.of(context).colorScheme;
  Size size = MediaQuery.of(context).size;
  List<DropdownMenuItem<int>> listItemDropDrown = listaItem(categoria);
  return Container(
    decoration: BoxDecoration(
        color: tema.surface,
        borderRadius: const BorderRadius.all(Radius.circular(3))),
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: 5),
    child: DropdownButton(
        iconDisabledColor: tema.surface,
        iconEnabledColor: tema.primary,
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(categoriaProvider.nombreCategoriaSelected,
            style: GoogleFonts.sourceSansPro(color: tema.onBackground)),
        items: listItemDropDrown,
        onChanged: (int? value) {
          categoriaProvider.idCategoriaSelected = value!;
          categoriaProvider.nombreCategoriaSelected =
              buscarNombre(categoria, value);
        }),
  );
}
