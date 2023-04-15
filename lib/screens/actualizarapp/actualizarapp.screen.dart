import 'package:flutter/material.dart';


import '../../constans.dart';
import '../../globals/widgets/widgets.dart';

class ActualizarAppScreen extends StatelessWidget {
  const ActualizarAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Icon(
                  Icons.system_update,
                  size: size.height * 0.2,
                  color: tema.primary,
                ),
                TextSecundario(
                  texto:
                      'Esta versión de la aplicación está desactualizada, por favor instale la última versión para continuar.',
                  colorTexto: tema.primary,
                ),
                TextParrafo(
                  texto: 'Versión actual: $version',
                  textAlign: TextAlign.center,
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
