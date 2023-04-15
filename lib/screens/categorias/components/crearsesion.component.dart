
import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/categorias.controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../globals/widgets/widgets.dart';
import '../../../providers/providers.dart';

class DialogCrearSesion {
  static void onCrearSesion(
    BuildContext contextMain,
  ) {
    Size size = MediaQuery.of(contextMain).size;
    final tema = Theme.of(contextMain).colorScheme;
    late TextEditingController txtTipoSesion = TextEditingController();
    final categoriaProvider =
        Provider.of<CategoriasProvider>(contextMain, listen: false);
    final servicioProvider =
        Provider.of<ServiciosProvider>(contextMain, listen: false);

    showDialog(
      context: contextMain,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        backgroundColor: tema.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Container(
          width: Platform.isWindows? size.width * 0.5 : size.width * 0.9 ,
          decoration: BoxDecoration(
              color: tema.secondary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: TextSecundario(
              texto: 'Crear Sesión',
              colorTexto: tema.onPrimary,
            ),
          ),
        ),
        titlePadding: const EdgeInsets.all(0),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextParrafo(texto: 'Tipo categoria'),
                TextField(
                  controller: txtTipoSesion,
                  onChanged: (String value) {},
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      border: const OutlineInputBorder(),
                      hintText: "Ej: Cumpleaños"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonXXL(
                  colorFondo: tema.secondary,
                  funcion: () async {
                    if (txtTipoSesion.text.isEmpty) {
                      alertError(context,
                          mensaje: 'Debe de crear una categoria');
                      return;
                    }
                    CategoriasController(categoriaProvider: categoriaProvider)
                        .crearCategoriaController(
                            contextMain, txtTipoSesion.text);
                    CategoriasController(categoriaProvider: categoriaProvider)
                        .traerCategoriasBySevicioController(
                            contextMain, servicioProvider.idServicio);
                    Navigator.pop(context);
                  },
                  texto: 'Crear Categoria',
                  sinMargen: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: 0, horizontal: size.width * 0.02),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: TextParrafo(
                texto: 'Regresar',
                colorTexto: tema.onPrimary,
              ))
        ],
      ),
    );
  }
}
