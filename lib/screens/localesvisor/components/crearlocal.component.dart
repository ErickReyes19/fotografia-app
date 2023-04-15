import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/controllers.dart';
import 'package:fotografia_app/controllers/servicios.controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../providers/providers.dart';

class DialogCrearLocal {
  static void onCrearLocal(
    BuildContext contextMain,
  ) {
    Size size = MediaQuery.of(contextMain).size;
    final tema = Theme.of(contextMain).colorScheme;
    late TextEditingController txtNombreLocal = TextEditingController();
    final localProvider =
        Provider.of<LocalesProvider>(contextMain, listen: false);

    showDialog(
      context: contextMain,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        backgroundColor: tema.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: tema.secondary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: TextSecundario(
              texto: 'Crear Local',
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
                const TextParrafo(texto: 'Nombre local'),
                TextField(
                  controller: txtNombreLocal,
                  onChanged: (String value) {},
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      border: const OutlineInputBorder(),
                      hintText: "Ej: Estudio"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonXXL(
                  colorFondo: tema.secondary,
                  funcion: () async {
                    if (txtNombreLocal.text.isEmpty) {
                      alertError(context,
                          mensaje: 'Debe de crear un local');
                      return;
                    }
                    LocalesController(localesProvider: localProvider)
                        .crearLocalesController(
                            contextMain,
                            txtNombreLocal.text
                            );
                    LocalesController(localesProvider: localProvider)
                        .traerLocalesController(
                            contextMain,
                            );
                    Navigator.pop(context);
                  },
                  texto: 'Crear Local',
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
