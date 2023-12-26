import 'package:flame/game.dart';
import 'package:flappy_dash/audio/audio_controller.dart';
import 'package:flappy_dash/flame_game/flappy_dash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';

class GameScene extends StatelessWidget {
  static const String backButtonKey = 'back_buttton';

  const GameScene({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController();

    return Scaffold(
      body: GameWidget<FlappyDash>(
        key: const Key('play session'),
        game: FlappyDash(
          audioController: audioController,
        ),
        overlayBuilderMap: {
          backButtonKey: (BuildContext context, FlappyDash game) {
            return Positioned(
              top: 20,
              right: 10,
              child: NesButton(
                type: NesButtonType.normal,
                onPressed: GoRouter.of(context).pop,
                child: NesIcon(iconData: NesIcons.leftArrowIndicator),
              ),
            );
          },
        },
      ),
    );
  }
}
