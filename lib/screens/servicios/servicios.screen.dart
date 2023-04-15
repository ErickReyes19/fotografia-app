import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import 'components/cardservicio.component.dart';
import 'components/crearservicio.component.dart';

class TraerServiciosScreen extends StatefulWidget {
  const TraerServiciosScreen({Key? key}) : super(key: key);
  @override
  State<TraerServiciosScreen> createState() => _TraerServiciosScreenState();
}

class _TraerServiciosScreenState extends State<TraerServiciosScreen> {
  @override
  Widget build(BuildContext context) {
    final serviciosProvider = Provider.of<ServiciosProvider>(context);
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
                actions: [FloatingActionButton(onPressed: (){
                  DialogCrearServicio.onCrearServicio(context);
                }, mini: true,child: const Icon(Icons.add),)],
                backgroundColor: tema.background,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      serviciosProvider.resetProvider();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: tema.primary,
                    )),
                titleSpacing: 0,
                title:
                    TextSecundario(texto: 'Servicios', colorTexto: tema.primary),
              ),
              serviciosProvider.listServicios.isNotEmpty?
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: serviciosProvider.listServicios.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardServiciosScreen(
                          servicio: serviciosProvider.listServicios[index]);
                    }),
              )
              : NoDataWidget(
                          tema: tema,
                          size: size,
                          texto: 'No se ecuentrar ordenes.',
                        )
            ],
          ),
        ),
        if (serviciosProvider.loading)
          CargandoWidget(size: size, conColor: true),
      ],
    ));
  }
}
