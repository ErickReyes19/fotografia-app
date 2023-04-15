import 'package:fotografia_app/models/models.dart';
import 'package:fotografia_app/providers/servicios.provider.dart';
import 'package:fotografia_app/services/servicios.service.dart';
import 'package:provider/provider.dart';
import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import 'auth.controller.dart';

class ServiciosController {
  final cuerpoController = CuerpoDeController();
  final ServiciosProvider serviciosProvider;
  ServiciosController({required this.serviciosProvider});

  Future<bool> traerServiciosController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final serviciosProvider =
          Provider.of<ServiciosProvider>(context, listen: false);
      serviciosProvider.loading = true;
      final respuesta = await traerServiciosService(token);

      if (respuesta is Servicios) {
        serviciosProvider.listServicios = respuesta.servicios;
        serviciosProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los servicios',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay servicios para mostrar');
        }, funcionFinal: () {
          serviciosProvider.listServicios = [];
          serviciosProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> traerServiciosActivosController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final serviciosProvider =
          Provider.of<ServiciosProvider>(context, listen: false);
      serviciosProvider.loading = true;
      final respuesta = await traerServiciosActivosService(token);

      if (respuesta is Servicios) {
        serviciosProvider.listServicios = respuesta.servicios;
        serviciosProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los servicios',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay servicios para mostrar');
        }, funcionFinal: () {
          serviciosProvider.listServicios = [];
          serviciosProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> crearServiciosController(context, String tipoServicio) async {
    final token = await traerToken(context);
    if (token != '') {
      final serviciosProvider =
          Provider.of<ServiciosProvider>(context, listen: false);
      serviciosProvider.loading = true;
      final respuesta = await crearServicioService(token, tipoServicio);

      if (respuesta is Servicios) {
        serviciosProvider.listServicios = respuesta.servicios;
        serviciosProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los servicios.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay servicios para mostrar');
        }, funcionFinal: () {
          serviciosProvider.listServicios = [];
          serviciosProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> actualizarServiciosController(context, String tipoServicio, bool activo, int id) async {
    final token = await traerToken(context);
    if (token != '') {
      final serviciosProvider =
          Provider.of<ServiciosProvider>(context, listen: false);
      serviciosProvider.loading = true;
      final respuesta = await actualizarServicioService(token, tipoServicio, activo, id);

      if (respuesta is Servicios) {
        serviciosProvider.listServicios = respuesta.servicios;
        serviciosProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los servicios.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay servicios para mostrar');
        }, funcionFinal: () {
          serviciosProvider.listServicios = [];
          serviciosProvider.loading = false;
        });
      }
    }
    return false;
  }
}

