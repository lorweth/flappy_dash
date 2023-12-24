import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/flame_game/flappy_dash_world.dart';
import 'package:flutter/material.dart';

class FlappyDash extends FlameGame<FlappyDashWorld> with HasCollisionDetection {
  FlappyDash(): super(
    world: FlappyDashWorld(),
    camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
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
  }
}
