import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/flame_game/components/player.dart';
import 'package:flappy_dash/flame_game/game_scene.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class FlappyDashWorld extends World with TapCallbacks, HasGameReference {
  final log = Logger('FlappyDashWorld');

  final scoreNotifier = ValueNotifier(0);

  late final Player player;

  Vector2 get size => (parent as FlameGame).size;

  /// The gravity is defined in virtual pixels per second squared.
  /// These pixels are in relation to how big the [FixedResolutionViewport] is.
  final double gravity = 10;

  /// Where the sky is located in the world and things should stop jumping.
  late final double skyLevel = (size.y / 5) - (size.y / 2);

  /// Where the ground is located in the world and things should stop falling.
  late final double groundLevel = (size.y / 2) - (size.y / 5);

  FlappyDashWorld();

  @override
  Future<void> onLoad() async {
    player = Player(
      position: Vector2(0, 0),
    );
    add(player);
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
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
