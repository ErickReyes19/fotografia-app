// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/servicios.controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../providers/providers.dart';

class DialogActualizarServicio extends StatefulWidget {
  final String tipoServicio;
  final bool activos;
  final int id;

  const DialogActualizarServicio({
    Key? key,
    required this.tipoServicio,
    required this.activos,
    required this.id,
  }) : super(key: key);

  @override
  _DialogActualizarServicioState createState() =>
      _DialogActualizarServicioState();
}

class _DialogActualizarServicioState extends State<DialogActualizarServicio> {
  late TextEditingController txtTipoServicio;
  late bool activo;

  @override
  void initState() {
    txtTipoServicio = TextEditingController(text: widget.tipoServicio);
    activo = widget.activos;
    super.initState();
  }

  @override
  Widget build(BuildContext contextMain) {
    Size size = MediaQuery.of(contextMain).size;
    final tema = Theme.of(contextMain).colorScheme;
    final serviciosProvider =
        Provider.of<ServiciosProvider>(contextMain, listen: false);

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
            texto: 'Actualizar Servicio',
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
              const TextParrafo(texto: 'Tipo Servicio'),
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
                  if (txtTipoServicio.text.isEmpty) {
                    alertError(contextMain,
                        mensaje: 'Debe de crear un servicio');
                    return;
                  }
                  ServiciosController(serviciosProvider: serviciosProvider)
                      .actualizarServiciosController(
                          contextMain, txtTipoServicio.text, activo, widget.id)
                      .then(
                        (value) => {
                          ServiciosController(
                                  serviciosProvider: serviciosProvider)
                              .traerServiciosController(
                            contextMain,
                          )
                        },
                      )
                      .then((value) => Navigator.pop(contextMain));
                },
                texto: 'actualizar Servicio',
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
