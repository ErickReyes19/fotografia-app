import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/cliente.controller.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/cliente.provider.dart';

class CrearClienteScreen extends StatefulWidget {
  const CrearClienteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CrearClienteScreen> createState() => _CrearClienteScreenState();
}

class _CrearClienteScreenState extends State<CrearClienteScreen>
    with WidgetsBindingObserver {
  late TextEditingController txtNombreCliente = TextEditingController();
  late TextEditingController txtMovil = TextEditingController();
  late TextEditingController txtIdentidad = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: customAppBar(
                tema: tema, titulo: "Crear cliente", context: context),
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
                  ButtonXXL(
                    funcion: () async {
                      if (num.tryParse(txtMovil.text) == null) {
                        alertError(context,
                            mensaje: 'El numero debe ser un número');
                        return;
                      }
                      ClientesController(clientesProvider: clientesProvider)
                          .crearClientesController(
                              context,
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
          if (clientesProvider.loading)
            CargandoWidget(size: size, conColor: true)
        ],
      ),
    );
  }
}
