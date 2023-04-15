import 'package:flutter/material.dart';

import '../../globals/widgets/widgets.dart';

class SinConexionScreen extends StatefulWidget {
  const SinConexionScreen({Key? key}) : super(key: key);

  @override
  State<SinConexionScreen> createState() => _SinConexionScreenState();
}

class _SinConexionScreenState extends State<SinConexionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tema = Theme.of(context).colorScheme;
    // final authprovider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Icon(
            Icons.cloud_off_rounded,
            size: size.height * 0.2,
            color: tema.primary,
          ),
          const TextSecundario(texto: 'No hay conexión.'),
          SizedBox(
            height: size.height * 0.2,
          ),
          // (authprovider.loading)
          // ?
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
                height: size.height * 0.01,
                width: size.width * 0.8,
                child: LinearProgressIndicator(
                  backgroundColor: tema.onPrimary,
                )),
          ),
          // :
          ButtonXXL(
              funcion: () {
                // AuthController(authProvider: authprovider)
                //     .validarTokenController(context);
              },
              texto: 'Recargar')
        ],
      ),
    );
  }
}
