import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constans.dart';
import '../models/models.dart';

Future login(String usuario, String password) async {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  final body = {"idapp": 1};
  try {
    String credentials = '$usuario:$password';

    var response = await http.post(
      Uri.parse('${apiUrl}auth'),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Basic ${stringToBase64.encode(credentials)}"
      },
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return tokenFromJson(response.body);
    if (response.statusCode == 400) return msgApiFromJson(response.body, false);
    if (response.statusCode == 500) return msgApiFromJson(response.body, true);
    return response.statusCode;
  } catch (e) {
    http.Client().close();
    if (e is TimeoutException) {
      return 4500;
    }
    if (e is SocketException) {
      return 4501;
    }
    return 1200;
  } finally {
    http.Client().close();
  }
}


Future validarTokenService(String token) async {
  try {
    var response = await http.get(
      Uri.parse('${apiUrl}auth/?idapp=1&versionApp=$version'),
      headers: {"x-token": token},
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      // return Permisos.fromJson(jsonDecode(response.body));
    }
    return response.statusCode;
  } catch (e) {
    http.Client().close();
    if (e is TimeoutException) {
      return 4500;
    }
    if (e is SocketException) {
      return 4501;
    }
    return 1200;
  } finally {
    http.Client().close();
  }
}
