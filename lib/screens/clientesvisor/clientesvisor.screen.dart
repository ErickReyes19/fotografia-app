import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../providers/cliente.provider.dart';
import 'components/cardclientes.component.dart';
import 'components/searchdelegate.component.dart';

class ClientesVisorScreen extends StatefulWidget {
  const ClientesVisorScreen({Key? key}) : super(key: key);

  @override
  State<ClientesVisorScreen> createState() => _ClientesVisorScreenState();
}

class _ClientesVisorScreenState extends State<ClientesVisorScreen> {
  TextEditingController controllerBusqueda = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final clienteProvider = Provider.of<ClientesProvider>(context);

    Size size = MediaQuery.of(context).size;
    final tema = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: tema.background,
      appBar: customAppBar(tema: tema, titulo: 'Clientes', context: context, funcionAtras: (){
        clienteProvider.resetProvider();
      }),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: 10),
              child: BuscadorCliente(controllerBusqueda: controllerBusqueda),
            ),
          ),
          clienteProvider.loading
              ? SliverToBoxAdapter(
                  child: SizedBox(
                      height: size.height * 0.6,
                      child: const Center(child: CircularProgressIndicator())),
                )
              : clienteProvider.listCliente.isEmpty
                  ? SliverToBoxAdapter(
                      child:
                          Center(child: NoDataWidget(tema: tema, size: size)))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => CardClientes(
                          cliente: clienteProvider.filtrandoCliente
                              ? clienteProvider.listFiltrado[i]
                              : clienteProvider.listCliente[i],
                        ),
                        childCount: clienteProvider.filtrandoCliente
                            ? clienteProvider.listFiltrado.length
                            : clienteProvider.listCliente.length,
                      ),
                    ),
        ],
      ),
    );
  }
}
