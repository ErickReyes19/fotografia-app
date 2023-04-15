import 'package:flutter/material.dart';

import 'package:fotografia_app/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/models.dart';

List<DropdownMenuItem<int>> listaItem(List<Locale> local) {
  List<DropdownMenuItem<int>> lista = [];
  for (var i = 0; i < local.length; i++) {
    lista.add(DropdownMenuItem(
      value: local[i].idLocal,
      child: Text(local[i].nombreLocal),
    ));
  }

  return lista;
}

String buscarNombre(List<Locale> listLocal, int idSeleccionado) {
  for (var categoria in listLocal) {
    if (categoria.idLocal == idSeleccionado) {
      return categoria.nombreLocal;
    }
  }
  return '';
}

Widget dropDownLocal(
    List<Locale> local, LocalesProvider localesProvider, context) {
  final tema = Theme.of(context).colorScheme;
  Size size = MediaQuery.of(context).size;
  List<DropdownMenuItem<int>> listItemDropDrown = listaItem(local);
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
        hint: Text(localesProvider.nombreLocalSelected,
            style: GoogleFonts.sourceSansPro(color: tema.onBackground)),
        items: listItemDropDrown,
        onChanged: (int? value) {
          localesProvider.idServicioSelected = value!;
          localesProvider.nombreLocalSelected =
              buscarNombre(local, value);
        }),
  );
}
