import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';
import 'package:intl/intl.dart';

import '../../actualizarpaquete/actualizarpaquete.screen.dart';

class CardPaquete extends StatefulWidget {
  const CardPaquete({Key? key, required this.paquete}) : super(key: key);

  final Paquete paquete;

  @override
  State<CardPaquete> createState() => _CardPaqueteState();
}

class _CardPaqueteState extends State<CardPaquete> {
  final formato = NumberFormat.decimalPattern('en_us');
  @override
  void initState() {
    initializeDateFormatting('es_MX', null);
    super.initState();
  }

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
                  texto: widget.paquete.nombrePaquete,
                  colorTexto: tema.onSurface,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: 3),
                decoration: BoxDecoration(
                    color: widget.paquete.activo ? Colors.green : Colors.red,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 100))),
                child: TextParrafo(
                    texto: widget.paquete.activo ? 'Activo' : 'Inactivo',
                    colorTexto: tema.onPrimary),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextSecundario(
                texto: 'Cantidad de fotos digitales: ',
                colorTexto: tema.secondary,
                textAlign: TextAlign.left,
              ),
              TextSecundario(
                texto: widget.paquete.catidadFotosDigitales.toString(),
                colorTexto: tema.onSurface,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Visibility(
            visible: widget.paquete.fotosImpresas,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextSecundario(
                  texto: 'Cantidad de fotos impresas: ',
                  colorTexto: tema.secondary,
                  textAlign: TextAlign.left,
                ),
                TextSecundario(
                  texto: widget.paquete.cantFotosImpresas.toString(),
                  colorTexto: tema.onSurface,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextSecundario(
                texto: 'Tiempo de cobertura: ',
                colorTexto: tema.secondary,
                textAlign: TextAlign.left,
              ),
              TextSecundario(
                texto: DateFormat('hh:mm','es-MX').format(widget.paquete.tiempoCobertura.toLocal()),
                colorTexto: tema.onSurface,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextSecundario(
                texto: 'Precio: ',
                colorTexto: tema.secondary,
                textAlign: TextAlign.left,
              ),
              TextSecundario(
                texto: 'Lps ${formato.format(widget.paquete.precio)}',
                colorTexto: tema.onSurface,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0), primary: tema.secondary),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ActualizarPaqueteScreen(
                              paquete: widget.paquete,
                            )));
              },
              child: const Text(
                'Editar',
              )),
        ],
      ),
    );
  }
}
