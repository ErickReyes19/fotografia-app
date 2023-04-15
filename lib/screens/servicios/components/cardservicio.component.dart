import 'package:flutter/material.dart';
import 'package:fotografia_app/controllers/categorias.controller.dart';
import 'package:fotografia_app/screens/categorias/categorias.screen.dart';
import 'package:provider/provider.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import 'actualizarservicio.component.dart';

class CardServiciosScreen extends StatefulWidget {
  const CardServiciosScreen({Key? key, required this.servicio})
      : super(key: key);

  final Servicio servicio;

  @override
  State<CardServiciosScreen> createState() => _CardServiciosScreenState();
}

class _CardServiciosScreenState extends State<CardServiciosScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriaProvider =
        Provider.of<CategoriasProvider>(context, listen: false);
    final servicioProvider =
        Provider.of<ServiciosProvider>(context, listen: false);
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
                  texto: widget.servicio.tipoServicio,
                  colorTexto: tema.onSurface,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: 3),
                decoration: BoxDecoration(
                    color: widget.servicio.activo ? Colors.green : Colors.red,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 100))),
                child: TextParrafo(
                    texto: widget.servicio.activo ? 'Activo' : 'Inactivo',
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
                      builder: (context) => DialogActualizarServicio(
                        tipoServicio: widget.servicio.tipoServicio,
                        activos: widget.servicio.activo,
                        id: widget.servicio.idServicio,
                      ),
                    );
                  },
                  child: const Text(
                    'Editar',
                  )),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      primary: tema.secondary),
                  onPressed: () {
                    servicioProvider.idServicio = widget.servicio.idServicio;
                    CategoriasController(categoriaProvider: categoriaProvider)
                        .traerCategoriasBySevicioController(
                            context, widget.servicio.idServicio);
                    
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TraerCategoriasScreen(
                                servicio: widget.servicio.tipoServicio)));
                  },
                  child: const Text(
                    'Categorias',
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
