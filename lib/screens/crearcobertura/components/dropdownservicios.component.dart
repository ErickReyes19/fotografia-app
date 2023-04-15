import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/categorias.controller.dart';
import 'package:fotografia_app/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';

List<DropdownMenuItem<int>> listaItem(List<Servicio> servicio) {
  List<DropdownMenuItem<int>> lista = [];
  for (var i = 0; i < servicio.length; i++) {
    lista.add(DropdownMenuItem(
      value: servicio[i].idServicio,
      child: Text(servicio[i].tipoServicio),
    ));
  }

  return lista;
}

String buscarNombre(List<Servicio> listServicio, int idSeleccionado) {
  for (var lugarEntrega in listServicio) {
    if (lugarEntrega.idServicio == idSeleccionado) {
      return lugarEntrega.tipoServicio;
    }
  }
  return '';
}

Widget dropDownServicios(
    List<Servicio> servicio, ServiciosProvider servicioProvider, context) {
  final tema = Theme.of(context).colorScheme;
  Size size = MediaQuery.of(context).size;
  List<DropdownMenuItem<int>> listItemDropDrown = listaItem(servicio);
  final categoriasProvider =
          Provider.of<CategoriasProvider>(context, listen: false);
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
        hint: Text(servicioProvider.nombreServicioSelected,
            style: GoogleFonts.sourceSansPro(color: tema.onBackground)),
        items: listItemDropDrown,
        
        onChanged: (int? value) {
          servicioProvider.idServicio = value!;
          categoriasProvider.resetProvider();
          CategoriasController(categoriaProvider: categoriasProvider).traerCategoriasBySevicioActivasController(context, value);
          servicioProvider.nombreServicioSelected =
              buscarNombre(servicio, value);
        }),
  );
}
