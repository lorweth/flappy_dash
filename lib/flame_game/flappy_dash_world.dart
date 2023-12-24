import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flappy_dash/flame_game/game_scene.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class FlappyDashWorld extends World with TapCallbacks, HasGameReference {
  final log = Logger('FlappyDashWorld');

  final scoreNotifier = ValueNotifier(0);

  FlappyDashWorld();

  @override
  void onTapDown(TapDownEvent event) {
    log.info('User has tap on {${event.localPosition.x}; ${event.localPosition.y}}');
    scoreNotifier.value++;
  }

  @override
  void onMount() {
    super.onMount();

    // When the world is mounted in the game we add a back button widget as an
    // overlay so that the player can go back to the previous screen.
    game.overlays.add(GameScene.backButtonKey);
  }

  @override
  void onRemove() {
    game.overlays.remove(GameScene.backButtonKey);
  }
}