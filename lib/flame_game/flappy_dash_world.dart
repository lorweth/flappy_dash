import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/flame_game/components/ground.dart';
import 'package:flappy_dash/flame_game/components/pipes.dart';
import 'package:flappy_dash/flame_game/components/player.dart';
import 'package:flappy_dash/flame_game/components/pool.dart';
import 'package:flappy_dash/flame_game/game_scene.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';


class FlappyDashWorld extends World with TapCallbacks, HasGameReference {
  final log = Logger('FlappyDashWorld');

  final scoreNotifier = ValueNotifier(0);

  late final Player player;
  late final int wallNumber = 3;

  Vector2 get size => (parent as FlameGame).size;

  /// The gravity is defined in virtual pixels per second squared.
  /// These pixels are in relation to how big the [FixedResolutionViewport] is.
  final double gravity = 10;

  /// Where the sky is located in the world and things should stop jumping.
  late final double skyLevel = (size.y / 5) - (size.y / 2);

  /// Where the ground is located in the world and things should stop falling.
  late final double groundLevel = (size.y / 2) - (size.y / 5);

  /// The speed is used for determining how fast the background should pass by
  /// and how fast the enemies and obstacles should move.
  late double speed = 400;

  FlappyDashWorld();

  @override
  Future<void> onLoad() async {
    // Add player to the world
    player = Player(
      position: Vector2(0, 0),
    );
    add(player);

    const obstacleScale = 3.0;
    final wallPool = ComponentPool<Pipes>.builder(
      wallNumber,
      Vector2((size.x / wallNumber) + (32*obstacleScale), 0),
      () => Pipes(
        worldSize: size,
        worldSpeed: speed,
        worldGroundLevel: groundLevel,
        scale: obstacleScale
      ),
    );
    addAll(wallPool.components);
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
