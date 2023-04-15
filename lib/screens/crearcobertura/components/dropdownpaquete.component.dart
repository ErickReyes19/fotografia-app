import 'package:flutter/material.dart';
import 'package:fotografia_app/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/models.dart';

List<DropdownMenuItem<int>> listaItem(List<Paquete> paquete) {
  List<DropdownMenuItem<int>> lista = [];
  for (var i = 0; i < paquete.length; i++) {
    lista.add(DropdownMenuItem(
      value: paquete[i].idPaquete,
      child: Text(paquete[i].nombrePaquete),
    ));
  }

  return lista;
}

String buscarNombre(List<Paquete> listPaquete, int idSeleccionado) {
  for (var categoria in listPaquete) {
    if (categoria.idPaquete == idSeleccionado) {
      return categoria.nombrePaquete;
    }
  }
  return '';
}

DateTime buscarHora(List<Paquete> listPaquete, int idSeleccionado) {
  for (var categoria in listPaquete) {
    if (categoria.idPaquete == idSeleccionado) {
      return categoria.tiempoCobertura.toLocal();
    }
  }
  return DateTime.now();
}

Widget dropDownPaquete(
    List<Paquete> paquete, PaqueteProvider paqueteProvider, context) {
  final tema = Theme.of(context).colorScheme;
  Size size = MediaQuery.of(context).size;
  List<DropdownMenuItem<int>> listItemDropDrown = listaItem(paquete);
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
        hint: Text(paqueteProvider.nombrePaqueteSelected,
            style: GoogleFonts.sourceSansPro(color: tema.onBackground)),
        items: listItemDropDrown,
        onChanged: (int? value) {
          paqueteProvider.idPaqueteSelected = value!;
          paqueteProvider.nombrePaqueteSelected = buscarNombre(paquete, value);
          
          paqueteProvider.cambiardireccionClienteController = DateFormat('hh:mm','es-MX').format(buscarHora(paquete, value));


        }),
  );
}
