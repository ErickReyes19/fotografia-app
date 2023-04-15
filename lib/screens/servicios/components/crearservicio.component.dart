import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/servicios.controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../providers/providers.dart';

class DialogCrearServicio {
  static void onCrearServicio(
    BuildContext contextMain,
  ) {
    Size size = MediaQuery.of(contextMain).size;
    final tema = Theme.of(contextMain).colorScheme;
    late TextEditingController txtTipoServicio = TextEditingController();
    final serviciosProvider =
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
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: tema.secondary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: TextSecundario(
              texto: 'Crear Servicio',
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
                const TextParrafo(texto: 'Tipo servicio'),
                TextField(
                  controller: txtTipoServicio,
                  onChanged: (String value) {},
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      border: const OutlineInputBorder(),
                      hintText: "Ej: Video"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonXXL(
                  colorFondo: tema.secondary,
                  funcion: () async {
                    if (txtTipoServicio.text.isEmpty) {
                      alertError(context,
                          mensaje: 'Debe de crear un servicio');
                      return;
                    }
                    ServiciosController(serviciosProvider: serviciosProvider)
                        .crearServiciosController(
                            contextMain,
                            txtTipoServicio.text
                            );
                    ServiciosController(serviciosProvider: serviciosProvider)
                        .traerServiciosController(
                            contextMain,
                            );
                    Navigator.pop(context);
                  },
                  texto: 'Crear Servicio',
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
