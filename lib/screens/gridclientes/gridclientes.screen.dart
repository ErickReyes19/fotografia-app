import 'package:flutter/material.dart';
import 'package:fotografia_app/screens/clientesvisor/clientesvisor.screen.dart';
import 'package:fotografia_app/screens/crearcliente/crearcliente.screen.dart';
import 'package:provider/provider.dart';

import '../../controllers/cliente.controller.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/cliente.provider.dart';

class GridClientesScreen extends StatefulWidget {
  const GridClientesScreen({Key? key}) : super(key: key);

  @override
  State<GridClientesScreen> createState() => _GridClientesScreenState();
}

class _GridClientesScreenState extends State<GridClientesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientesProvider =
        Provider.of<ClientesProvider>(context, listen: false);
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: tema.primary,
            )),
        titleSpacing: 0,
        title: TextSecundario(texto: 'Clientes', colorTexto: tema.onBackground),
      ),
      backgroundColor: tema.background,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.03,
                top: size.height * 0.02,
                right: size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: GridItem(
                                icono: Icons.event,
                                funcion: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const CrearClienteScreen()));
                                },
                                texto: 'Crear Clientes'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GridItem(
                                icono: Icons.person_search_outlined,
                                funcion: () {
                                  ClientesController(
                                          clientesProvider: clientesProvider)
                                      .traerClientesController(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const ClientesVisorScreen()));
                                },
                                texto: 'Ver Clientes'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
