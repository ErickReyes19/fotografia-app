import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';
import '../../../providers/cliente.provider.dart';

class BuscadorCliente extends StatelessWidget {
  const BuscadorCliente({
    Key? key,
    required this.controllerBusqueda,
  }) : super(key: key);

  final TextEditingController controllerBusqueda;
  String _displayStringForOption(Cliente cliente) => cliente.nombre;

  @override
  Widget build(BuildContext context) {
    final clienteProvider = Provider.of<ClientesProvider>(context);
    return Autocomplete<Cliente>(
        fieldViewBuilder: (BuildContext context, fieldTextEditingController,
            fieldFocusNode, onFieldSubmitted) {
          return TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            onChanged: (String value) {
              controllerBusqueda.text = value;
              clienteProvider.filtrandoCliente = true;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(

                    onPressed: () {
                      fieldTextEditingController.clear();
                      clienteProvider.filtrandoCliente = false;
                      controllerBusqueda.clear();
                      FocusScope.of(context).unfocus();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color:
                          clienteProvider.filtrandoCliente ? Colors.red : null,
                    )),
                label: const TextParrafo(texto: 'Cliente'),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
                hintText: 'Seleccione un cliente'),
          );
        },
        displayStringForOption: _displayStringForOption,
        onSelected: (Cliente seleccion) {
          
          

        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            clienteProvider.listFiltrado = clienteProvider.listCliente;
            return [];
            // return const Iterable<Producto>.empty();
          }
          clienteProvider.listFiltrado = clienteProvider.listCliente
              .where((producto) => producto.nombre
                  .toUpperCase()
                  .contains(textEditingValue.text.toUpperCase()))
              .toList();
          return [];
        });
  }
}
