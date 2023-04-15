import 'package:fotografia_app/models/models.dart';

import 'package:provider/provider.dart';
import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../providers/providers.dart';
import '../services/categorias.service.dart';
import 'auth.controller.dart';

class CategoriasController {
  final cuerpoController = CuerpoDeController();
  final CategoriasProvider categoriaProvider;
  CategoriasController({required this.categoriaProvider});

  Future<bool> traerCategoriasBySevicioController(context, int idServicio) async {
    final token = await traerToken(context);
    if (token != '') {
      final sesionProvider =
          Provider.of<CategoriasProvider>(context, listen: false);
      sesionProvider.loading = true;
      final respuesta = await traerCategoriasService(token, idServicio);

      if (respuesta is Categorias) {
        sesionProvider.listCategorias = respuesta.categorias;
        sesionProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar las categorias',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay categorias para mostrar');
        }, funcionFinal: () {
          sesionProvider.listCategorias = [];
          sesionProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> traerCategoriasBySevicioActivasController(context, int idServicio) async {
    final token = await traerToken(context);
    if (token != '') {
      final sesionProvider =
          Provider.of<CategoriasProvider>(context, listen: false);
      sesionProvider.loading = true;
      final respuesta = await traerCategoriasActivasService(token, idServicio);

      if (respuesta is Categorias) {
        sesionProvider.listCategorias = respuesta.categorias;
        sesionProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar las categorias',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          categoriaProvider.nombreCategoriaSelected = 'No hay categoria en este servicio';
          alertError(context, mensaje: 'No hay categorias para mostrar');
        }, funcionFinal: () {
          sesionProvider.listCategorias = [];
          sesionProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> crearCategoriaController(context, String tipoServicio) async {
    final token = await traerToken(context);
    if (token != '') {
      final categoriaProvider =
          Provider.of<CategoriasProvider>(context, listen: false);
      final servicioProvider =
          Provider.of<ServiciosProvider>(context, listen: false);
      categoriaProvider.loading = true;
      final respuesta = await crearCategoriaService(token, tipoServicio, servicioProvider.idServicio);

      if (respuesta is Categorias) {
        categoriaProvider.listCategorias = respuesta.categorias;
        categoriaProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar las categorias.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay categorias para mostrar');
        }, funcionFinal: () {
          categoriaProvider.listCategorias = [];
          categoriaProvider.loading = false;
        });
      }
    }
    return false;
  }

  Future<bool> actualizarSesionController(context, String tipoSesion, bool activo, int id) async {
    final token = await traerToken(context);
    if (token != '') {
      final serviciosProvider =
          Provider.of<CategoriasProvider>(context, listen: false);
      serviciosProvider.loading = true;
      final respuesta = await actualizarSesionService(token, tipoSesion, activo, id);

      if (respuesta is Categorias) {
        serviciosProvider.listCategorias = respuesta.categorias;
        serviciosProvider.loading = false;
        return true;
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'cargar las categorias.',
            codRespuesta: respuesta, funcion401: () {
          AuthController().logoutController(context);
        }, funcion404: () {
          alertError(context, mensaje: 'No hay categorias para mostrar');
        }, funcionFinal: () {
          serviciosProvider.listCategorias = [];
          serviciosProvider.loading = false;
        });
      }
    }
    return false;
  }
}

