import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/audio/audio_controller.dart';
import 'package:flappy_dash/flame_game/flappy_dash_world.dart';
import 'package:flutter/material.dart';

class FlappyDash extends FlameGame<FlappyDashWorld> with HasCollisionDetection {
  /// A helper for playing sound effects and background audio.
  final AudioController audioController;

  FlappyDash({
    required this.audioController,
  }) : super(
          world: FlappyDashWorld(),
          camera: CameraComponent.withFixedResolution(width: 720, height: 1600),
        );

  @override
  Future<void> onLoad() async {
    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    final scoreComponent = TextComponent(
      text: '0',
      position: Vector2.all(30),
      textRenderer: textRenderer,
    );

    camera.viewport.add(scoreComponent);

    // Here we add a listener to the notifier that is updated when the player
    // gets a new point, in the callback we update the text of the
    // `scoreComponent`.
    world.scoreNotifier.addListener(() {
      scoreComponent.text = '${world.scoreNotifier.value}';
    });

    // Preload all Sfx audio when start
    audioController.preloadSfx();
  }
}
