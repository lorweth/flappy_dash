import 'package:flappy_dash/router.dart';
import 'package:flappy_dash/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Flame.device.fullScreen();
  // await Flame.device.setPortrait();
  runApp(const MyGame());
}

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Palette()), // Provide palette
      ],
      child: Builder(builder: (context) {
        final palette = context.watch<Palette>();

        return MaterialApp.router(
          title: 'Flappy Dash',
          theme: flutterNesTheme().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: palette.seed.color,
              background: palette.backgroundMain.color,
            ),
            textTheme: GoogleFonts.pressStart2pTextTheme().apply(
              bodyColor: palette.text.color,
              displayColor: palette.text.color,
            ),
          ),
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
        );
      }),
    );
  }
}
