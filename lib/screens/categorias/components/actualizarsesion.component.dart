// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fotografia_app/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controllers/categorias.controller.dart';
import '../../../globals/widgets/widgets.dart';

class DialogActualizarSesion extends StatefulWidget {
  final String tipoSesion;
  final bool activos;
  final int id;

  const DialogActualizarSesion({
    Key? key,
    required this.tipoSesion,
    required this.activos,
    required this.id,
  }) : super(key: key);

  @override
  _DialogActualizarSesionState createState() => _DialogActualizarSesionState();
}

class _DialogActualizarSesionState extends State<DialogActualizarSesion> {
  late TextEditingController txtTipoSesion;
  late bool activo;

  @override
  void initState() {
    txtTipoSesion = TextEditingController(text: widget.tipoSesion);
    activo = widget.activos;
    super.initState();
  }

  @override
  Widget build(BuildContext contextMain) {
    final categoriasProvider =
        Provider.of<CategoriasProvider>(context, listen: false);
    final serviciosProvider =
        Provider.of<ServiciosProvider>(context, listen: false);
    Size size = MediaQuery.of(contextMain).size;
    final tema = Theme.of(contextMain).colorScheme;

    return AlertDialog(
      backgroundColor: tema.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Container(
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: tema.secondary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: TextSecundario(
            texto: 'Actualizar Sesión',
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
              const TextParrafo(texto: 'Tipo Categoria'),
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
                  hintText: "Ej: Video",
                ),
              ),
              const TextParrafo(texto: 'Estado'),
              Switch(
                value: activo,
                onChanged: (value) {
                  setState(() {
                    activo = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonXXL(
                colorFondo: tema.secondary,
                funcion: () async {
                  if (txtTipoSesion.text.isEmpty) {
                    alertError(contextMain,
                        mensaje: 'Debe de crear un servicio');
                    return;
                  }
                  CategoriasController(categoriaProvider: categoriasProvider)
                      .actualizarSesionController(
                          contextMain, txtTipoSesion.text, activo, widget.id)
                      .then(
                        (value) => {
                          CategoriasController(
                                  categoriaProvider: categoriasProvider)
                              .traerCategoriasBySevicioController(
                                  contextMain, serviciosProvider.idServicio)
                        },
                      )
                      .then((value) => Navigator.pop(contextMain));
                },
                texto: 'actualizar Sesion',
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
    );
  }
}
