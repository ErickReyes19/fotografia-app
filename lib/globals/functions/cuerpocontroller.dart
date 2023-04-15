

import '../../services/internetChecked.service.dart';
import '../widgets/widgets.dart';

class CuerpoDeController {
  cuerpoNormal(
    context, {
    required String mensajeError,
    required int codRespuesta,
    Function()? funcion400,
    Function()? funcion401,
    Function()? funcion404,
    Function()? funcion409,
    Function()? funcion500,
    Function()? funcion1200,
    Function()? funcion4500,
    Function()? funcion4501,
    Function()? funcionFinal,
  }) async {
    switch (codRespuesta) {
      case 400:
        alertError(context,
            mensaje: 'Error en los parametros al $mensajeError.');
        funcion400?.call();
        break;
      case 401:
        funcion401?.call();
        globalSnackBar('Por favor inicie sesión para realizar esta acción');
        break;
      case 409:
        funcion409?.call();
        break;
      case 404:
        funcion404?.call();
        break;
      case 500:
        funcion500?.call();
        alertError(context,
            mensaje:
                'Ocurrió un error interno en el servidor al $mensajeError, contacte con soporte técnico.');
        break;
      case 1200:
        funcion1200?.call();
        alertError(context, mensaje: 'Ocurrió un error al $mensajeError.');
        break;
      case 4500:
        funcion4500?.call();
        await manejoDeConexionAinternet(context);
        break;
      case 4501:
        funcion4501?.call();
        alertError(context,
            mensaje:
                'Ocurrió un error al $mensajeError, verifique si:  tiene conexión a internet, los datos móviles o el wifi están activados, se encuentra conectado a una red interna sin acceso al servidor.');
        break;
      default:
    }
    funcionFinal?.call();
  }
}
