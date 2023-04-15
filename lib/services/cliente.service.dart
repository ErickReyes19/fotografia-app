import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constans.dart';
import '../models/models.dart';

traerClientesService(String token) async {
  try {
    var response = await http.get(Uri.parse('${apiUrl}cliente'),
        headers: {"x-token": token}).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return clientesFromJson(response.body);
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

traerClientesActivosService(String token) async {
  try {
    var response = await http.get(Uri.parse('${apiUrl}cliente/activos'),
        headers: {"x-token": token}).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return clientesFromJson(response.body);
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

insertarClientes(
  String token,
  String nombreCliente,
  String movil,
  String identidad,
) async {
  try {
    final body = {
      "nombre": nombreCliente,
      "numerocelular": movil,
      "identidad": identidad,
    };

    var response = await http
        .post(Uri.parse('${apiUrl}cliente/'),
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
insertarClientesEsperarId(
  String token,
  String nombreCliente,
  String movil,
  String identidad,
) async {
  try {
    final body = {
      "nombre": nombreCliente,
      "numerocelular": movil,
      "identidad": identidad,
    };

    var response = await http
        .post(Uri.parse('${apiUrl}cliente/'),
            headers: {"x-token": token, "Content-Type": "application/json"},
            body: jsonEncode(body))
        .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) return idClienteFromJson(response.body);

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

actualizarClienteService(
  String token,
  String nombre,
  String numeroCelular,
  String identidad,
  bool activo,
  int idCliente,
) async {
  try {
    final body = {
      "nombre": nombre,
      "numerocelular": numeroCelular,
      "identidad": identidad,
      "activo": activo,
      "idCliente": idCliente
    };

    var response = await http
        .put(Uri.parse('${apiUrl}cliente/'),
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
