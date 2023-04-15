import 'package:flutter/material.dart';

import '../../constans.dart';
import '../../controllers/auth.controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AuthController().validarTokenController(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tema = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: tema.background,
        body: Center(
          child: ListView(
            children: [
              SizedBox(height: size.height * 0.2),
              Image.asset(AppAssets().logoAppWhite,
                    width: size.width * 0.5, height: size.height * 0.25),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  )),
            ],
          ),
        ));
  }
}
