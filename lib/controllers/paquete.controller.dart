import 'package:flutter/material.dart';
import 'package:fotografia_app/providers/providers.dart';
import 'package:fotografia_app/services/paquete.service.dart';
import 'package:provider/provider.dart';
import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import 'auth.controller.dart';

class PaqueteController {
  final cuerpoController = CuerpoDeController();
  final PaqueteProvider paqueteProvider;
  PaqueteController({required this.paqueteProvider});

  Future<bool> traerPaquetesController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final paquetesProvider =
          Provider.of<PaqueteProvider>(context, listen: false);
      paquetesProvider.loading = true;
      final respuesta = await traerPaqueteService(token);

      if (respuesta is Paquetes) {
        paquetesProvider.listPaquete = respuesta.paquetes;
        paquetesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los paquetes',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay paquetes para mostrar');
        }, funcionFinal: () {
          paqueteProvider.listPaquete = [];
          paqueteProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> traerPaquetesActivosController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final paquetesProvider =
          Provider.of<PaqueteProvider>(context, listen: false);
      paquetesProvider.loading = true;
      final respuesta = await traerPaqueteActivosService(token);

      if (respuesta is Paquetes) {
        paquetesProvider.listPaquete = respuesta.paquetes;
        paquetesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los paquetes',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay paquetes para mostrar');
        }, funcionFinal: () {
          paqueteProvider.listPaquete = [];
          paqueteProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> crearPaqueteController(
      context,
      String nombrePaquete,
      int catidadFotosDigitales,
      bool fotosImpresas,
      int cantFotosImpresas,
      String tiempoCobertura,
      double precio) async {
    final token = await traerToken(context);
    if (token != '') {
      final paqueteProvider =
          Provider.of<PaqueteProvider>(context, listen: false);
      paqueteProvider.loading = true;
      final respuesta = await insertarPaquete(
          token,
          nombrePaquete,
          catidadFotosDigitales,
          fotosImpresas,
          cantFotosImpresas,
          tiempoCobertura,
          precio);
      if (respuesta == 200) {
        sncackbarGlobal('Paquete agregado con éxito.', color: Colors.green);
        Navigator.pop(context);
        paqueteProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'crear el paquete',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcionFinal: () {
          paqueteProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> actualizarPaqueteController(
      context,
      String nombrePaquete,
      int catidadFotosDigitales,
      bool fotosImpresas,
      int cantFotosImpresas,
      String tiempoCobertura,
      double precio,
      bool activo,
      int idPaquete) async {
    final token = await traerToken(context);
    if (token != '') {
      final paquetesProvider =
          Provider.of<PaqueteProvider>(context, listen: false);
      paquetesProvider.loading = true;
      final respuesta = await actualizarPaqueteService(
          token,
          nombrePaquete,
          catidadFotosDigitales,
          fotosImpresas,
          cantFotosImpresas,
          tiempoCobertura,
          precio,
          activo,
          idPaquete);

      if (respuesta == 200) {
        paquetesProvider.loading = false;
        Navigator.pop(context);
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'crear el paquete.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcionFinal: () {
          paquetesProvider.listPaquete = [];
          paquetesProvider.loading = false;
        });
      }
    }
    return false;
  }
}
