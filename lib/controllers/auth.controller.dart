import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotografia_app/providers/auth.provider.dart';
import 'package:provider/provider.dart';

import '../globals/functions/functions.dart';
import '../globals/functions/resetprovider.function.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../screens/actualizarapp/actualizarapp.screen.dart';
import '../screens/home/home.screen.dart';
import '../screens/login/login.screen.dart';
import '../screens/sinconexion/sinconexion.screen.dart';
import '../services/auth.service.dart';

class AuthController {
  final cuerpoController = CuerpoDeController();
  final AuthProvider? authProvider;

  AuthController({this.authProvider});

  Future<bool> loginController(String usuario, String password, context) async {
    if (usuario.isEmpty || password.isEmpty) {
      alertError(context, mensaje: 'Por favor complete todos los campos');
      authProvider?.errorText = 'Este campo es obligatorio';
      authProvider?.error = true;
    } else {
      authProvider?.loading = true;
      final respuesta = await login(usuario.trim(), password.trim());
      if (respuesta is Token) {
        const storage = FlutterSecureStorage();
        storage.write(key: 'token', value: respuesta.token);
        storage.write(key: 'user', value: usuario.trim());
        authProvider?.nombreUsuario = usuario;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (Route<dynamic> route) => false);
        authProvider?.loading = false;
        return true;
      } else if (respuesta is MsgApi) {
        authProvider?.loading = false;
        if (respuesta.msg != null) {
          if (respuesta.aplicaAlert) {
            alertError(context, mensaje: respuesta.msg!);
            return false;
          }
          authProvider?.error = true;
          authProvider?.errorText = respuesta.msg!;
          return false;
        } else {
          alertError(context, mensaje: respuesta.errors![0]);
          return false;
        }
      } else {
        cuerpoController.cuerpoNormal(context,
            mensajeError: 'iniciar sesion',
            codRespuesta: respuesta, funcion409: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ActualizarAppScreen()),
              (Route<dynamic> route) => false);
        }, funcion401: () {
          globalSnackBar('Por favor inicie sesión para realizar esta acción.');
        }, funcionFinal: () {
          authProvider?.loading = false;
        });
      }
    }
    authProvider?.loading = false;
    return false;
  }

  Future validarTokenController(context) async {
    const storage = FlutterSecureStorage();
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    final token = await storage.read(key: 'token');

    if (token != null) {
      authprovider.loading = true;
      final respuesta = await validarTokenService(token);
      if (respuesta == 200) {
        authprovider.loading = false;
        final nombreUsuario = await storage.read(key: 'user');
        
        authprovider.nombreUsuario = nombreUsuario ?? '';
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        return true;
      }
      CuerpoDeController().cuerpoNormal(context,
          mensajeError: 'cargar los datos de usuario',
          codRespuesta: respuesta,
          funcion401: () {
            logoutController(context);
            globalSnackBar('Por favor inicie sesión.');
          },
          funcion404: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ActualizarAppScreen()),
              (Route<dynamic> route) => false),
          funcion500: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const LoginScreen())),
          funcion4500: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SinConexionScreen())),
          funcion4501: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SinConexionScreen())));
      authprovider.loading = false;
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      globalSnackBar('Por favor inicie sesión.');
    }
  }

  Future logoutController(context) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'token');
      await storage.delete(key: 'user');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (Route<dynamic> route) => false);
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }
    resetProviders(context);
  }
}


