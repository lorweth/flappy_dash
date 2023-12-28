import 'package:flappy_dash/audio/audio_controller.dart';
import 'package:flappy_dash/audio/sounds.dart';
import 'package:flappy_dash/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final audioController = context.read<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/banner.png',
              filterQuality: FilterQuality.none,
            ),
            _gap,
            Transform.rotate(
              angle: -0.1,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: const Text(
                  'A Flutter game template.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Press Start 2P',
                    fontSize: 32,
                    height: 1,
                  ),
                ),
              ),
            ),
            _gap,
            NesButton(
              type: NesButtonType.primary,
              onPressed: () {
                audioController.playSfx(SfxType.buttonTap);
                GoRouter.of(context).go('/play');
              },
              child: const Text('Play'),
            ),
            _gap,
            const Text('Built with Flame'),
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
