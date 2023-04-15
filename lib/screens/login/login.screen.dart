import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constans.dart';
import '../../controllers/auth.controller.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/auth.provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtUser = TextEditingController(text: '');
  TextEditingController txtPass = TextEditingController(text: '');
  bool verContrasena = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tema = Theme.of(context).colorScheme;
    final authprovider = Provider.of<AuthProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: tema.background,
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Center(
                child: Image.asset(AppAssets().logoAppWhite,
                    width: size.width * 0.5, height: size.height * 0.25),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextPrincipal(
                      texto: 'Autenticación',
                      colorTexto: tema.primary,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Ingrese sus credenciales para acceder.',
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.width * 0.05,
                  bottom: size.height * 0.01,
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                ),
                child: TextField(
                  controller: txtUser,
                  onChanged: (String value) {
                    if (value.isNotEmpty && authprovider.error) {
                      authprovider.error = false;
                    }
                  },
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      // errorText:
                          // authprovider.error ? authprovider.errorText : null,
                      border: const OutlineInputBorder(),
                      hintText: 'Usuario'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  // vertical: size.height * 0.01
                ),
                child: TextField(
                  controller: txtPass,
                  obscureText: verContrasena,
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      errorText:
                          authprovider.error ? authprovider.errorText : null,
                      errorBorder: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            (!verContrasena)
                                ? verContrasena = true
                                : verContrasena = false;
                            setState(() {});
                          },
                          icon: Icon(
                            (!verContrasena)
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                          )),
                      border: const OutlineInputBorder(),
                      hintText: 'Contraseña'),
                ),
              ),
              SizedBox(
                height: size.height * 0.10,
              ),
              // Checkbox(value: false, onChanged: (bool) {}),
              ButtonXXL(
                funcion: () {
                  AuthController(authProvider: authprovider).loginController(
                      txtUser.text.trim(), txtPass.text.trim(), context);
                },
                texto: 'Iniciar sesión',
                colorTexto: tema.background,
              ),
              SizedBox(
                height: size.height * 0.02,
              )
            ],
          ),
          if (authprovider.loading)
            Container(
              color: Colors.black12,
              width: size.width,
              height: size.height,
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    ));
  }
}
