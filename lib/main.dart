
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constans.dart';
import 'providers/providers.dart';
import 'screens/splashscreen/splash.screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ClientesProvider()),
        ChangeNotifierProvider(create: (context) => ServiciosProvider()),
        ChangeNotifierProvider(create: (context) => CategoriasProvider()),
        ChangeNotifierProvider(create: (context) => PaqueteProvider()),
        ChangeNotifierProvider(create: (context) => LocalesProvider()),
      ],
      child: CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: snackbarKey,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Color(0xffF2F2F2)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff312E5C))),
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Color(0xffD95204),
                  onPrimary: Color.fromARGB(255, 255, 255, 255),
                  secondary: Color(0xff312E5C),
                  onSecondary: Colors.white,
                  error: Colors.red,
                  onError: Colors.white,
                  background: Color.fromARGB(255, 245, 245, 245),
                  onBackground: Color.fromARGB(255, 36, 36, 36),
                  surface: Color.fromARGB(255, 255, 255, 255),
                  onSurface: Color.fromARGB(255, 13, 0, 44),
                  onSurfaceVariant: Color.fromARGB(255, 102, 102, 102)),
            ),
            title: 'Material App',
            home: const SplashScreen()),
      ),
    );
  }
}
