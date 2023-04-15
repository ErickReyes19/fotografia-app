import 'package:flutter/material.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';
import 'actualizarlocal.component.dart';
class CardLocalesScreen extends StatefulWidget {
  const CardLocalesScreen({Key? key, required this.local})
      : super(key: key);

  final Locale local;

  @override
  State<CardLocalesScreen> createState() => _CardLocalesScreenState();
}

class _CardLocalesScreenState extends State<CardLocalesScreen> {
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
                  texto: widget.local.nombreLocal,
                  colorTexto: tema.onSurface,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: 3),
                decoration: BoxDecoration(
                    color: widget.local.activo ? Colors.green : Colors.red,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 100))),
                child: TextParrafo(
                    texto: widget.local.activo ? 'Activo' : 'Inactivo',
                    colorTexto: tema.onPrimary),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      primary: tema.secondary),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DialogActualizarLocal(
                        nombreLocal: widget.local.nombreLocal,
                        activos: widget.local.activo,
                        id: widget.local.idLocal,
                      ),
                    );
                  },
                  child: const Text(
                    'Editar',
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
