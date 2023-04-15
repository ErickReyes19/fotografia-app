import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/cliente.controller.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/cliente.provider.dart';

class ActualizarClienteScreen extends StatefulWidget {
  final String nombreCliente;
  final String identidad;
  final String movil;
  final bool activo;
  final int id;

  const ActualizarClienteScreen({
    Key? key,
    required this.nombreCliente,
    required this.identidad,
    required this.movil,
    required this.activo,
    required this.id,
  }) : super(key: key);

  @override
  State<ActualizarClienteScreen> createState() =>
      _ActualizarClienteScreenState();
}

class _ActualizarClienteScreenState extends State<ActualizarClienteScreen>
    with WidgetsBindingObserver {
  late TextEditingController txtNombreCliente =
      TextEditingController(text: widget.nombreCliente);
  late TextEditingController txtMovil =
      TextEditingController(text: widget.movil);
  late TextEditingController txtIdentidad =
      TextEditingController(text: widget.identidad);
  late bool activos;

  @override
  void initState() {
    super.initState();
    txtNombreCliente = TextEditingController(text: widget.nombreCliente);
    txtMovil = TextEditingController(text: widget.movil);
    txtIdentidad = TextEditingController(text: widget.identidad);
    activos = widget.activo;
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return Stack(
      children: [
        Scaffold(
          appBar: customAppBar(
              tema: tema, titulo: "Actualizar Cliente", context: context),
          backgroundColor: tema.background,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: ListView(
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
                const TextParrafo(texto: 'Estado'),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Switch(
                    value: activos,
                    onChanged: (value) {
                      setState(() {
                        activos = value;
                      });
                    },
                  ),
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
                        .actualizarClientesController(
                            context,
                            txtNombreCliente.text,
                            txtMovil.text,
                            txtIdentidad.text,
                            activos,
                            widget.id)
                        .then((value) => ClientesController(clientesProvider: clientesProvider).traerClientesController(context)).then((value) => Navigator.pop(context));
                  },
                  texto: 'Actualizar cliente',
                  sinMargen: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        if (clientesProvider.loading)
          CargandoWidget(size: size, conColor: true)
      ],
    );
  }
}
