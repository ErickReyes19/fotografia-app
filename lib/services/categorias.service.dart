import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fotografia_app/models/models.dart';
import 'package:http/http.dart' as http;
import '../constans.dart';

traerCategoriasService(String token, int idServicio) async {
  try {
    var response = await http.get(
        Uri.parse('${apiUrl}categoria?servicioId=$idServicio'),
        headers: {"x-token": token}).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return categoriasFromJson(response.body);
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
traerCategoriasActivasService(String token, int idServicio) async {
  try {
    var response = await http.get(
        Uri.parse('${apiUrl}categoria/activas?servicioId=$idServicio'),
        headers: {"x-token": token}).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return categoriasFromJson(response.body);
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

crearCategoriaService(String token, String tipoSesion, int idServicio) async {
  try {
    final body = {
      "idServicio": idServicio,
      "tipoCategoria": tipoSesion,
    };

    var response = await http
        .post(Uri.parse('${apiUrl}categoria/'),
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

actualizarSesionService(
  String token,
  String tipoSesion,
  bool activo,
  int id,
) async {
  try {
    final body = {"tipoCategoria": tipoSesion, "activo": activo, "idCategoria": id};

    var response = await http
        .put(Uri.parse('${apiUrl}categoria/'),
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
