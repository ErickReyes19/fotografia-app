import 'package:flutter/material.dart';
import 'package:fotografia_app/screens/localesvisor/components/crearlocal.component.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import 'components/cardlocales.component.dart';

class TraerLocalesScreen extends StatefulWidget {
  const TraerLocalesScreen({Key? key}) : super(key: key);
  @override
  State<TraerLocalesScreen> createState() => _TraerLocalesScreenState();
}

class _TraerLocalesScreenState extends State<TraerLocalesScreen> {
  @override
  Widget build(BuildContext context) {
    final localesProvider = Provider.of<LocalesProvider>(context);
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
                  DialogCrearLocal.onCrearLocal(context);
                }, mini: true,child: const Icon(Icons.add),)],
                backgroundColor: tema.background,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      localesProvider.resetProvider();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: tema.primary,
                    )),
                titleSpacing: 0,
                title:
                    TextSecundario(texto: 'Locales', colorTexto: tema.primary),
              ),
              localesProvider.listLocales.isNotEmpty?
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: localesProvider.listLocales.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardLocalesScreen(
                          local: localesProvider.listLocales[index]);
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
        if (localesProvider.loading)
          CargandoWidget(size: size, conColor: true),
      ],
    ));
  }
}
