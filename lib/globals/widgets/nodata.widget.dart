import 'package:flutter/material.dart';

import 'widgets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.tema,
    required this.size,
    this.icono,
    this.texto,
  }) : super(key: key);

  final ColorScheme tema;
  final Size size;
  final IconData? icono;
  final String? texto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icono ?? Icons.upcoming_outlined,
          color: tema.secondary,
          size: size.height * 0.2,
        ),
        TextParrafo(texto: texto ?? 'No hay datos para mostrar')
      ],
    );
  }
}
