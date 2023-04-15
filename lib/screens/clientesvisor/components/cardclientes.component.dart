import 'package:flutter/material.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';
import '../../actualizarcliente/actualizarcliente.screen.dart';

class CardClientes extends StatefulWidget {
  const CardClientes({Key? key, required this.cliente}) : super(key: key);

  final Cliente cliente;

  @override
  State<CardClientes> createState() => _CardClientesState();
}

class _CardClientesState extends State<CardClientes> {
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
                  texto: widget.cliente.nombre,
                  colorTexto: tema.onSurface,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: 3),
                decoration: BoxDecoration(
                    color: widget.cliente.activo ? Colors.green : Colors.red,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 100))),
                child: TextParrafo(
                    texto: widget.cliente.activo ? 'Activo' : 'Inactivo',
                    colorTexto: tema.onPrimary),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextParrafo(
                    texto: "Identidad: ",
                    textAlign: TextAlign.left,
                    colorTexto: tema.onSurface,
                  ),
                  TextParrafo(
                    texto: widget.cliente.identidad.isEmpty
                        ? 'No disponible'
                        : widget.cliente.identidad,
                    textAlign: TextAlign.right,
                    colorTexto: tema.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextParrafo(
                texto: "Movil: ",
                textAlign: TextAlign.left,
                colorTexto: tema.onSurface,
              ),
              TextParrafo(
                texto: widget.cliente.numerocelular,
                textAlign: TextAlign.right,
                colorTexto: tema.onSurfaceVariant,
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
                        builder: (_) => ActualizarClienteScreen(
                              activo: widget.cliente.activo,
                              id: widget.cliente.idCliente,
                              identidad: widget.cliente.identidad,
                              movil: widget.cliente.numerocelular,
                              nombreCliente: widget.cliente.nombre,
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
