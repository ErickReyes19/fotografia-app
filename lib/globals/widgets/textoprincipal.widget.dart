import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextPrincipal extends StatelessWidget {
  const TextPrincipal({
    Key? key,
    required this.texto,
    this.colorTexto,
  }) : super(key: key);

  final String texto;
  final Color? colorTexto;

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700, fontSize: 18, color: colorTexto ?? Colors.black87));
  }
}
