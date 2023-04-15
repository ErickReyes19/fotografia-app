import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fotografia_app/providers/providers.dart';
import 'package:fotografia_app/screens/crearcobertura/components/buscarcliente.component.dart';
import 'package:fotografia_app/screens/crearcobertura/components/dropdowncategorias.component.dart';
import 'package:fotografia_app/screens/crearcobertura/components/dropdownlocales.component.dart';
import 'package:fotografia_app/screens/crearcobertura/components/dropdownpaquete.component.dart';
import 'package:fotografia_app/screens/crearcobertura/components/dropdownservicios.component.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/cliente.controller.dart';
import '../../globals/widgets/widgets.dart';
import 'components/dialogcrearcliente.component.dart';

class CrearCoberturaScreen extends StatefulWidget {
  const CrearCoberturaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CrearCoberturaScreen> createState() => _CrearCoberturaScreenState();
}

class _CrearCoberturaScreenState extends State<CrearCoberturaScreen>
    with WidgetsBindingObserver {
  late TextEditingController txtNombreCliente = TextEditingController();
  late TextEditingController txtMovil = TextEditingController();
  late TextEditingController txtIdentidad = TextEditingController();
  late TextEditingController txtLugar = TextEditingController();

  TextEditingController txtFechaController = TextEditingController();
  TextEditingController txtHoraController = TextEditingController();

  @override
  void initState() {
    initializeDateFormatting('es_MX', null);
    txtFechaController.text = DateFormat.yMMMd('es-MX').format(DateTime.now());
    super.initState();
  }

  DateTime fechaCobertura = DateTime.now();
  late DateTime horaCobertua;
  bool horasEstas = false;
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final clientesProvider = Provider.of<ClientesProvider>(context);
    final categoriaProvider = Provider.of<CategoriasProvider>(context);
    final serviciosProvider = Provider.of<ServiciosProvider>(context);
    final paqueteProvider = Provider.of<PaqueteProvider>(context);
    final localesProvider = Provider.of<LocalesProvider>(context);

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: customAppBar(
                tema: tema, titulo: "Crear cliente", context: context),
            backgroundColor: tema.background,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: ListView(
                children: [
                  const TextParrafo(
                      texto: 'Cliente', textAlign: TextAlign.left),
                  Row(
                    children: [
                      const Expanded(flex: 7, child: BuscadorClientes()),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                            onPressed: () {
                              DialogCrearCliente.onMostrarDetalleFactura(
                                  context);
                              setState(() {});
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                            ),
                            child: Icon(
                              Icons.person_add_outlined,
                              color: tema.onPrimary,
                            )),
                      )
                    ],
                  ),
                  const TextParrafo(
                      texto: 'Servicio', textAlign: TextAlign.left),
                  dropDownServicios(serviciosProvider.listServicios,
                      serviciosProvider, context),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(
                      texto: 'Categoria', textAlign: TextAlign.left),
                  dropDownCategoria(categoriaProvider.listCategorias,
                      categoriaProvider, context),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(
                      texto: 'Paquete', textAlign: TextAlign.left),
                  dropDownPaquete(
                      paqueteProvider.listPaquete, paqueteProvider, context),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(texto: 'Fecha de cobertura'),
                  TextField(
                    readOnly: true,
                    controller: txtFechaController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.02,
                              bottom: 4.5,
                              right: size.width * 0.02),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: tema.primary,
                              ),
                            ],
                          ),
                        )),
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2050, 3, 5),
                          onChanged: (date) {}, onConfirm: (date) {
                        fechaCobertura = date;
                        txtFechaController.text =
                            DateFormat.yMMMd('es-MX').format(fechaCobertura);
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                  ),
                  const TextParrafo(texto: 'Horas extras'),
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: Switch(
                        value: horasEstas,
                        onChanged: (bool value) {
                          setState(() {
                            horasEstas = value;
                          });
                        },
                      )),
                  const TextParrafo(texto: 'Tiempo de Cobertura'),
                  TextField(
                    enabled: horasEstas,
                    readOnly: true,
                    controller: paqueteProvider.txtTiempoCobertura,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.02,
                              bottom: 4.5,
                              right: size.width * 0.02),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: tema.primary,
                              ),
                            ],
                          ),
                        )),
                    onTap: () {
                      DatePicker.showTimePicker(context,
                          showTitleActions: true,
                          onChanged: (date) {}, onConfirm: (date) {
                        paqueteProvider.tiempoCobeturaSelected = date;

                        paqueteProvider.cambiardireccionClienteController =
                            DateFormat('hh:mm', 'es-MX').format(date.toLocal());

                        txtHoraController.text = DateFormat('hh:mm', 'es-MX')
                            .format(paqueteProvider.tiempoCobeturaSelected
                                .toLocal());
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(texto: 'Direccion del lugar'),
                  TextField(
                    controller: txtLugar,
                    onChanged: (String value) {},
                    style: TextStyle(color: tema.onBackground),
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        hintStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        border: const OutlineInputBorder(),
                        hintText: "Ej: Barrio el estadio"),
                  ),
                  const TextParrafo(
                      texto: 'Local', textAlign: TextAlign.left),
                  dropDownLocal(
                      localesProvider.listLocales, localesProvider, context),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(texto: 'Identidad'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: txtIdentidad,
                    onChanged: (String value) {},
                    style: TextStyle(color: tema.onBackground),
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        hintStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        border: const OutlineInputBorder(),
                        hintText: "Ej: 060220001548"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonXXL(
                    funcion: () async {
                      if (num.tryParse(txtMovil.text) == null) {
                        alertError(context,
                            mensaje: 'El numero debe ser un número');
                        return;
                      }
                      ClientesController(clientesProvider: clientesProvider)
                          .crearClientesController(
                              context,
                              txtNombreCliente.text,
                              txtMovil.text,
                              txtIdentidad.text);
                    },
                    texto: 'Crear cliente',
                    sinMargen: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          if (clientesProvider.loading)
            CargandoWidget(size: size, conColor: true)
        ],
      ),
    );
  }
}
