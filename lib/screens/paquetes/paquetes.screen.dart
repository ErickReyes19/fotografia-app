import 'package:flutter/material.dart';
import 'package:fotografia_app/screens/paquetes/components/cardpaquete.component.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import '../crearpaquete/crearpaquete.screen.dart';

class TraerPaquetesScreen extends StatefulWidget {
  const TraerPaquetesScreen({Key? key}) : super(key: key);
  @override
  State<TraerPaquetesScreen> createState() => _TraerPaquetesScreenState();
}

class _TraerPaquetesScreenState extends State<TraerPaquetesScreen> {
  @override
  Widget build(BuildContext context) {
    final paquetesProvider = Provider.of<PaqueteProvider>(context);
    Size size = MediaQuery.of(context).size;
    final tema = Theme.of(context).colorScheme;
    return SafeArea(
        child: Stack(
      children: [
        Scaffold(
          backgroundColor: tema.background,
          body: Column(
            children: [
              AppBar(
                actions: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CrearPaqueteScreen()));
                    },
                    mini: true,
                    child: const Icon(Icons.add),
                  )
                ],
                backgroundColor: tema.background,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      paquetesProvider.resetProvider();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: tema.primary,
                    )),
                titleSpacing: 0,
                title:
                    TextSecundario(texto: 'Paquetes', colorTexto: tema.primary),
              ),
              paquetesProvider.listPaquete.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: paquetesProvider.listPaquete.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardPaquete(
                                paquete: paquetesProvider.listPaquete[index]);
                          }),
                    )
                  : NoDataWidget(
                      tema: tema,
                      size: size,
                      texto: 'No se ecuentrar categorias.',
                    )
            ],
          ),
        ),
        if (paquetesProvider.loading)
          CargandoWidget(size: size, conColor: true),
      ],
    ));
  }
}
