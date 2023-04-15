import 'package:flutter/material.dart';

import '../../constans.dart';



sncackbarGlobal(String texto, {Color? color = Colors.red}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    content: Text(texto),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}
