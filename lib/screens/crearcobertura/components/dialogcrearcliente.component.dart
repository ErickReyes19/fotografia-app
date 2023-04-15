import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controllers.dart';
import '../../../globals/widgets/widgets.dart';
import '../../../providers/providers.dart';

class DialogCrearCliente {
  static void onMostrarDetalleFactura(
    BuildContext contextMain,
  ) {
    Size size = MediaQuery.of(contextMain).size;
    final tema = Theme.of(contextMain).colorScheme;
    late TextEditingController txtNombreCliente = TextEditingController();
    late TextEditingController txtMovil = TextEditingController();
    late TextEditingController txtIdentidad = TextEditingController();
    final clientesProvider =
        Provider.of<ClientesProvider>(contextMain, listen: false);

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
              color: tema.primary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: TextSecundario(
              texto: 'Crear Cliente',
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
                const TextParrafo(texto: 'Nombre Cliente'),
                TextField(
                  controller: txtNombreCliente,
                  onChanged: (String value) {},
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      border: const OutlineInputBorder(),
                      hintText: "Ej: Mario Ponce"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextParrafo(texto: 'Movil'),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: txtMovil,
                  onChanged: (String value) {},
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      border: const OutlineInputBorder(),
                      hintText: "Ej: 88223344"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextParrafo(texto: 'Identidad'),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: txtIdentidad,
                  onChanged: (String value) {},
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      border: const OutlineInputBorder(),
                      hintText: "Ej: 060220001548"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonXXL(
                  funcion: () async {
                    if (num.tryParse(txtMovil.text) == null) {
                      alertError(context,
                          mensaje: 'El numero debe ser un número');
                      return;
                    }
                    ClientesController(clientesProvider: clientesProvider)
                        .crearClientesController(
                            contextMain,
                            txtNombreCliente.text,
                            txtMovil.text,
                            txtIdentidad.text);
                    
                  },
                  texto: 'Crear cliente',
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
