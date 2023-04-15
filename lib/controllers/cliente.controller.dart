import 'package:flutter/material.dart';
import 'package:fotografia_app/providers/cliente.provider.dart';
import 'package:provider/provider.dart';
import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/clientes.model.dart';
import '../models/models.dart';
import '../services/cliente.service.dart';
import 'auth.controller.dart';

class ClientesController {
  final cuerpoController = CuerpoDeController();
  final ClientesProvider clientesProvider;
  ClientesController({required this.clientesProvider});

  Future<bool> traerclientesNombresController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final clientesProvider =
          Provider.of<ClientesProvider>(context, listen: false);
      clientesProvider.loading = true;
      final respuesta = await traerClientesService(token);

      if (respuesta is Clientes) {
        clientesProvider.listCliente = respuesta.clientes;
        clientesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los clientes',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay clientes para mostrar');
        }, funcionFinal: () {
          clientesProvider.listCliente = [];
          clientesProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> traerClientesController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final rellenosProvider =
          Provider.of<ClientesProvider>(context, listen: false);
      rellenosProvider.loading = true;
      final respuesta = await traerClientesService(token);

      if (respuesta is Clientes) {
        rellenosProvider.listCliente = respuesta.clientes;
        rellenosProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar las citas',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay citas para mostrar');
        }, funcionFinal: () {
          clientesProvider.listCliente = [];
          clientesProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> traerClientesActivosController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final rellenosProvider =
          Provider.of<ClientesProvider>(context, listen: false);
      rellenosProvider.loading = true;
      final respuesta = await traerClientesActivosService(token);

      if (respuesta is Clientes) {
        rellenosProvider.listCliente = respuesta.clientes;
        rellenosProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar las citas',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay citas para mostrar');
        }, funcionFinal: () {
          clientesProvider.listCliente = [];
          clientesProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> crearClientesController(
      context, String nombreCliente, String movil, String identidad) async {
    final token = await traerToken(context);
    if (nombreCliente.isEmpty || movil.isEmpty) {
      alertError(context, mensaje: 'Debe de poner un nombre y un movil');
      return false;
    }
    if (token != '') {
      final clientesProvider =
          Provider.of<ClientesProvider>(context, listen: false);
      clientesProvider.loading = true;
      final respuesta =
          await insertarClientes(token, nombreCliente, movil, identidad);
      if (respuesta == 200) {
        sncackbarGlobal('Cliente agregado con éxito.', color: Colors.green);
        ClientesController(clientesProvider: clientesProvider)
            .traerClientesController(context);
        // clientesProvider.cambiarNombreClienteController =
        Navigator.pop(context);
        clientesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'crear los clientes',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcionFinal: () {
          clientesProvider.loading = false;
        });
      }
    }
    return false;
  }



  Future<bool> actualizarClientesController(
    context,
    String nombre,
    String numeroCelular,
    String identidad,
    bool activo,
    int idCliente,
  ) async {
    final token = await traerToken(context);
    if (token != '') {
      final clientesProvider =
          Provider.of<ClientesProvider>(context, listen: false);
      clientesProvider.loading = true;
      final respuesta = await actualizarClienteService(
          token, nombre, numeroCelular, identidad, activo, idCliente);

      if (respuesta is Clientes) {
        clientesProvider.listCliente = respuesta.clientes;
        clientesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los servicios.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay servicios para mostrar');
        }, funcionFinal: () {
          clientesProvider.listCliente = [];
          clientesProvider.loading = false;
        });
      }
    }
    return false;
  }
}
