import 'package:fotografia_app/models/models.dart';
import 'package:fotografia_app/providers/providers.dart';
import 'package:fotografia_app/services/locales.service.dart';
import 'package:provider/provider.dart';
import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import 'auth.controller.dart';

class LocalesController {
  final cuerpoController = CuerpoDeController();
  final LocalesProvider localesProvider;
  LocalesController({required this.localesProvider});

  Future<bool> traerLocalesController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final localesProvider =
          Provider.of<LocalesProvider>(context, listen: false);
      localesProvider.loading = true;
      final respuesta = await traerLocalesService(token);

      if (respuesta is Locales) {
        localesProvider.listLocales = respuesta.locales;
        localesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los locales',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay locales para mostrar');
        }, funcionFinal: () {
          localesProvider.listLocales = [];
          localesProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> traerLocalesActivosController(context) async {
    final token = await traerToken(context);
    if (token != '') {
      final localesProvider =
          Provider.of<LocalesProvider>(context, listen: false);
      localesProvider.loading = true;
      final respuesta = await traerLocalesActivosService(token);

      if (respuesta is Locales) {
        localesProvider.listLocales = respuesta.locales;
        localesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los locales',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay locales para mostrar');
        }, funcionFinal: () {
          localesProvider.listLocales = [];
          localesProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> crearLocalesController(context, String nombreLocal) async {
    final token = await traerToken(context);
    if (token != '') {
      final localeProvider =
          Provider.of<LocalesProvider>(context, listen: false);
      localeProvider.loading = true;
      final respuesta = await crearLocalService(token, nombreLocal);

      if (respuesta is Locales) {
        localeProvider.listLocales = respuesta.locales;
        localeProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los locales.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay locales para mostrar');
        }, funcionFinal: () {
          localeProvider.listLocales = [];
          localeProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> actualizarLocalesController(context, String nombreLocal, bool activo, int id) async {
    final token = await traerToken(context);
    if (token != '') {
      final localesProvider =
          Provider.of<LocalesProvider>(context, listen: false);
      localesProvider.loading = true;
      final respuesta = await actualizarLocalesService(token, nombreLocal, activo, id);

      if (respuesta is Locales) {
        localesProvider.listLocales = respuesta.locales;
        localesProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar los locales.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay locales para mostrar');
        }, funcionFinal: () {
          localesProvider.listLocales = [];
          localesProvider.loading = false;
        });
      }
    }
    return false;
  }
}

