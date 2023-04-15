import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import 'components/cardcategorias.component.dart';
import 'components/crearsesion.component.dart';

class TraerCategoriasScreen extends StatefulWidget {
  const TraerCategoriasScreen({Key? key, required this.servicio}) : super(key: key);
final String servicio;
  @override
  State<TraerCategoriasScreen> createState() => _TraerCategoriasScreenState();
}
class _TraerCategoriasScreenState extends State<TraerCategoriasScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriasProvider = Provider.of<CategoriasProvider>(context);
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
                      DialogCrearSesion.onCrearSesion(context);
                    },
                    mini: true,
                    child: const Icon(Icons.add),
                  )
                ],
                backgroundColor: tema.background,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      categoriasProvider.resetProvider();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: tema.primary,
                    )),
                titleSpacing: 0,
                title:
                    TextSecundario(texto: widget.servicio, colorTexto: tema.primary),
              ),
              categoriasProvider.listCategorias.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: categoriasProvider.listCategorias.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardCategorias(
                                categoria:
                                    categoriasProvider.listCategorias[index]);
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
        if (categoriasProvider.loading)
          CargandoWidget(size: size, conColor: true),
      ],
    ));
  }
}
