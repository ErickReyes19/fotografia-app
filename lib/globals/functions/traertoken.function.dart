
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth.controller.dart';
import '../../providers/auth.provider.dart';




Future traerToken(context) async{
  final authprovider = Provider.of<AuthProvider>(context, listen: false);
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  if (token != null) {
    return token;
  }
  // logo(usuario, password, context)
  AuthController(authProvider:authprovider).logoutController(context);
  return '';
}

