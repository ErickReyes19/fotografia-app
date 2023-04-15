import 'package:flutter/material.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';
import 'actualizarsesion.component.dart';

class CardCategorias extends StatefulWidget {
  const CardCategorias({Key? key, required this.categoria})
      : super(key: key);

  final Categoria categoria;

  @override
  State<CardCategorias> createState() => _CardCategoriasState();
}

class _CardCategoriasState extends State<CardCategorias> {
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: size.width * 0.03),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
          color: tema.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextSecundario(
                  texto: widget.categoria.tipoCategoria,
                  colorTexto: tema.onSurface,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: 3),
                decoration: BoxDecoration(
                    color: widget.categoria.activo ? Colors.green : Colors.red,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 100))),
                child: TextParrafo(
                    texto: widget.categoria.activo ? 'Activo' : 'Inactivo',
                    colorTexto: tema.onPrimary),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0), primary: tema.secondary),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      DialogActualizarSesion(
                    tipoSesion: widget.categoria.tipoCategoria,
                    activos: widget.categoria.activo, id: widget.categoria.idCategoria,
                  ),
                );
              },
              child: const Text(
                'Editar',
              )),
        ],
      ),
    );
  }
}
