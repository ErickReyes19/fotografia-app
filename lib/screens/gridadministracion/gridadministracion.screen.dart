import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/controllers.dart';
import 'package:fotografia_app/screens/localesvisor/localesvisor.screen.dart';
import 'package:fotografia_app/screens/paquetes/paquetes.screen.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import '../servicios/servicios.screen.dart';

class GridAdministracionScreen extends StatefulWidget {
  const GridAdministracionScreen({Key? key}) : super(key: key);

  @override
  State<GridAdministracionScreen> createState() =>
      _GridAdministracionScreenState();
}

class _GridAdministracionScreenState extends State<GridAdministracionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviciosProvider =
        Provider.of<ServiciosProvider>(context, listen: false);
    final paquetesProvider =
        Provider.of<PaqueteProvider>(context, listen: false);
    final localesProvider =
        Provider.of<LocalesProvider>(context, listen: false);
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
        title: TextSecundario(
            texto: 'Administración', colorTexto: tema.onBackground),
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
                                icono: Icons.photo_camera_outlined,
                                funcion: () {
                                  ServiciosController(
                                          serviciosProvider: serviciosProvider)
                                      .traerServiciosController(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const TraerServiciosScreen()));
                                },
                                texto: 'Servicio'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GridItem(
                                icono: Icons.camera_alt_outlined,
                                funcion: () {
                                  PaqueteController(
                                          paqueteProvider: paquetesProvider)
                                      .traerPaquetesController(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const TraerPaquetesScreen()));
                                },
                                texto: 'Paquetes'),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: GridItem(
                                icono: Icons.photo_camera_outlined,
                                funcion: () {
                                  LocalesController(
                                          localesProvider: localesProvider)
                                      .traerLocalesController(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const TraerLocalesScreen()));
                                },
                                texto: 'Locales'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child:Center()
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
