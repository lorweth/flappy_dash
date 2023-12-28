import 'package:flappy_dash/audio/audio_controller.dart';
import 'package:flappy_dash/audio/sounds.dart';
import 'package:flappy_dash/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

class GamePauseDialog extends StatelessWidget {
  final int? score;
  final VoidCallback restart;
  final AudioController audioController;

  const GamePauseDialog({
    super.key,
    this.score,
    required this.restart,
    required this.audioController,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Center(
      child: NesContainer(
        width: 420,
        height: 280,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Well done!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You score ${score ?? 0}.',
              textAlign: TextAlign.center,
            ),
            _gap,
            NesButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonTap);
                restart();
              },
              type: NesButtonType.normal,
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
