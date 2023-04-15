import 'package:flutter/material.dart';

Widget cuerpoPantallaGridItem(List<Widget> listOpciones, context) {
  Size size = MediaQuery.of(context).size;
  List<Widget> listFilas = [];

  for (var i = 0; i < listOpciones.length; i += 2) {
    listFilas.add(IntrinsicHeight(
      child: Row(
        children: [
          ...listOpciones
              .sublist(i, i == listOpciones.length - 1 ? i + 1 : i + 2)
              .map((e) => Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      child: e))),
          if (i == listOpciones.length - 1) const Expanded(child: SizedBox())
        ],
      ),
    ));
  }

  return Column(
    children: listFilas,
  );
}
