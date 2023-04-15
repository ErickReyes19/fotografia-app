import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fotografia_app/models/models.dart';
import 'package:http/http.dart' as http;
import '../constans.dart';

traerPaqueteService(String token) async {
  try {
    var response = await http.get(Uri.parse('${apiUrl}paquete'),
        headers: {"x-token": token}).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return paquetesFromJson(response.body);
    } else if (response.statusCode == 400) {
      return 400;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    if (e is TimeoutException) {
      http.Client().close();
      return 4500;
    }
    if (e is SocketException) {
      http.Client().close();
      return 4501;
    }
    return 1200;
  } finally {
    http.Client().close();
  }
}
traerPaqueteActivosService(String token) async {
  try {
    var response = await http.get(Uri.parse('${apiUrl}paquete/activos'),
        headers: {"x-token": token}).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return paquetesFromJson(response.body);
    } else if (response.statusCode == 400) {
      return 400;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 404) {
      return 404;
    } else if (response.statusCode == 500) {
      return 500;
    }
  } catch (e) {
    if (e is TimeoutException) {
      http.Client().close();
      return 4500;
    }
    if (e is SocketException) {
      http.Client().close();
      return 4501;
    }
    return 1200;
  } finally {
    http.Client().close();
  }
}

insertarPaquete(
  String token,
  String nombrePaquete,
  int catidadFotosDigitales,
  bool fotosImpresas,
  int cantFotosImpresas,
  String tiempoCobertura,
  double precio,
) async {
  try {
    final body = {
      "nombrePaquete": nombrePaquete,
      "catidadFotosDigitales": catidadFotosDigitales,
      "fotosImpresas": fotosImpresas,
      "cantFotosImpresas": cantFotosImpresas,
      "tiempoCobertura": tiempoCobertura,
      "precio": precio
    };

    var response = await http
        .post(Uri.parse('${apiUrl}paquete/'),
            headers: {"x-token": token, "Content-Type": "application/json"},
            body: jsonEncode(body))
        .timeout(const Duration(seconds: 15));
    return response.statusCode;
  } catch (e) {
    if (e is TimeoutException) {
      http.Client().close();
      return 4500;
    }
    if (e is SocketException) {
      http.Client().close();
      return 4501;
    }
    return 1200;
  } finally {
    http.Client().close();
  }
}


actualizarPaqueteService(
  String token,
  String nombrePaquete,
  int catidadFotosDigitales,
  bool fotosImpresas,
  int cantFotosImpresas,
  String tiempoCobertura,
  double precio,
  bool activo, 
  int idPaquete
) async {
  try {
    final body = {
      "nombrePaquete": nombrePaquete,
      "catidadFotosDigitales": catidadFotosDigitales,
      "fotosImpresas": fotosImpresas,
      "cantFotosImpresas": cantFotosImpresas,
      "tiempoCobertura": tiempoCobertura,
      "precio": precio,
      "activo": activo,
      "idPaquete": idPaquete,
    };

    var response = await http
        .put(Uri.parse('${apiUrl}paquete/'),
            headers: {"x-token": token, "Content-Type": "application/json"},
            body: jsonEncode(body))
        .timeout(const Duration(seconds: 15));
    return response.statusCode;
  } catch (e) {
    if (e is TimeoutException) {
      http.Client().close();
      return 4500;
    }
    if (e is SocketException) {
      http.Client().close();
      return 4501;
    }
    return 1200;
  } finally {
    http.Client().close();
  }
}