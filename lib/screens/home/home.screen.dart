import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/controllers.dart';
import 'package:fotografia_app/providers/providers.dart';
import 'package:fotografia_app/screens/crearcobertura/crearcobertura.screen.dart';
import 'package:fotografia_app/screens/gridadministracion/gridadministracion.screen.dart';
import 'package:fotografia_app/screens/gridclientes/gridclientes.screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final authprovider = Provider.of<AuthProvider>(context, listen: true);
    final serviciosProvider = Provider.of<ServiciosProvider>(context, listen: true);
    final paqueteProvider = Provider.of<PaqueteProvider>(context, listen: true);
    final localesProvider = Provider.of<LocalesProvider>(context, listen: true);
    final clientesProvider =
        Provider.of<ClientesProvider>(context, listen: true);
    return Scaffold(
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
                RichText(
                    text: TextSpan(
                        style: GoogleFonts.poppins(
                            fontSize: 21, fontWeight: FontWeight.w600),
                        children: [
                      TextSpan(
                          text: '¡Hola ',
                          style: TextStyle(color: tema.secondary)),
                      TextSpan(
                          text: '${authprovider.nombreUsuario}!',
                          style: GoogleFonts.poppins(color: tema.primary)),
                    ])),
                TextParrafo(
                  texto: '¿Qué deseas hacer hoy?',
                  colorTexto: tema.onBackground,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: GridItem(
                                icono: Icons.event,
                                funcion: () {
                                  PaqueteController(paqueteProvider:paqueteProvider).traerPaquetesActivosController(context);
                                  LocalesController(localesProvider:localesProvider).traerLocalesActivosController(context);
                                  ServiciosController(serviciosProvider: serviciosProvider).traerServiciosActivosController(context);
                                  ClientesController(
                                          clientesProvider: clientesProvider)
                                      .traerClientesActivosController(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const CrearCoberturaScreen()));
                                },
                                texto: 'Nueva Sesión'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GridItem(
                                icono: Icons.person_search_outlined,
                                funcion: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const GridClientesScreen()));
                                },
                                texto: 'Clientes'),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: GridItem(
                                icono: Icons.contact_support_outlined,
                                funcion: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const GridAdministracionScreen()));
                                },
                                texto: 'Administración'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GridItem(
                                icono: Icons.data_saver_off_rounded,
                                funcion: () {
                                  alertMantenimiento(context);
                                },
                                texto: 'Consultas'),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: GridItem(
                                icono: Icons.logout_rounded,
                                funcion: () {
                                  dialogDecision('Cerrar sesión',
                                      '¿Está seguro que desea cerrar sesión?',
                                      () {
                                    AuthController(authProvider: authprovider)
                                        .logoutController(context);
                                  }, () {
                                    Navigator.pop(context);
                                  }, context);
                                },
                                texto: 'Cerrar Sesión'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(child: Center()),
                        ],
                      ),
                    )
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
