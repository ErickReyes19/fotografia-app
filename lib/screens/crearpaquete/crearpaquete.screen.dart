import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fotografia_app/controllers/controllers.dart';
import 'package:fotografia_app/providers/providers.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:intl/date_symbol_data_local.dart';
import '../../globals/widgets/widgets.dart';

class CrearPaqueteScreen extends StatefulWidget {
  const CrearPaqueteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CrearPaqueteScreen> createState() => _CrearPaqueteScreenState();
}

class _CrearPaqueteScreenState extends State<CrearPaqueteScreen>
    with WidgetsBindingObserver {
  late TextEditingController txtNombrePaquete = TextEditingController();
  late TextEditingController txtCantDig = TextEditingController();
  late TextEditingController txtPrecio = TextEditingController();
  late TextEditingController txtCatnImp = TextEditingController(text: '0');
  TextEditingController txtHora = TextEditingController();
  late DateTime hora;

  @override
  void initState() {
    
    txtHora.text = DateFormat('hh:mm','es-MX').format(DateTime(0,0,0,1,0));
    initializeDateFormatting('es_MX', null);
    super.initState();
  }

  bool fotosImpr = false;
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    final paqueteProvider = Provider.of<PaqueteProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: customAppBar(
                tema: tema, titulo: "Crear paquete", context: context),
            backgroundColor: tema.background,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: ListView(
                children: [
                  const TextParrafo(texto: 'Nombre paquete'),
                  TextField(
                    controller: txtNombrePaquete,
                    onChanged: (String value) {},
                    style: TextStyle(color: tema.onBackground),
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        hintStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        border: const OutlineInputBorder(),
                        hintText: "Ej: Paquete basico"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(texto: 'Cantidad de fotos digitales'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: txtCantDig,
                    onChanged: (String value) {},
                    style: TextStyle(color: tema.onBackground),
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        hintStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        border: const OutlineInputBorder(),
                        hintText: "Ej: 15"),
                  ),
                  const TextParrafo(texto: 'Fotos Impresas'),
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: Switch(
                        value: fotosImpr,
                        onChanged: (bool value) {
                          setState(() {
                            fotosImpr = value;
                          });
                        },
                      )),
                  Visibility(
                      visible: fotosImpr,
                      child: const TextParrafo(
                          texto: 'Cantidad de fotos impresas')),
                  Visibility(
                    visible: fotosImpr,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: txtCatnImp,
                      onChanged: (String value) {},
                      style: TextStyle(color: tema.onBackground),
                      decoration: InputDecoration(
                          labelStyle: GoogleFonts.sourceSansPro(
                              color: tema.onBackground),
                          hintStyle: GoogleFonts.sourceSansPro(
                              color: tema.onBackground),
                          border: const OutlineInputBorder(),
                          hintText: "Ej: 15"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(texto: 'Hora de cobertura'),
                  TextField(
                    readOnly: true,
                    controller: txtHora,
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
                        hora = date;
                        txtHora.text = hora.toString().substring(11, 16);
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(texto: 'Precio'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: txtPrecio,
                    onChanged: (String value) {},
                    style: TextStyle(color: tema.onBackground),
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        hintStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        border: const OutlineInputBorder(),
                        hintText: "Ej: 1200"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonXXL(
                    funcion: () async {
                      int cantDigital = int.parse(txtCantDig.text);
                      int cantImpresa = int.parse(txtCatnImp.text);
                      double precio = double.parse(txtPrecio.text);

                      PaqueteController(paqueteProvider: paqueteProvider)
                          .crearPaqueteController(
                              context,
                              txtNombrePaquete.text,
                              cantDigital,
                              fotosImpr,
                              cantImpresa,
                              txtHora.text,
                              precio);
                      PaqueteController(paqueteProvider: paqueteProvider).traerPaquetesController(context);
                    },
                    texto: 'Crear Paquete',
                    sinMargen: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          if (paqueteProvider.loading)
            CargandoWidget(size: size, conColor: true)
        ],
      ),
    );
  }
}
