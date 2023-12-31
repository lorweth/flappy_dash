import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/flame_game/components/obstacle.dart';
import 'package:flappy_dash/flame_game/flappy_dash.dart';
import 'package:flutter/material.dart';

class Ground extends SpriteComponent
    with HasGameReference<FlappyDash>
    implements Obstacle {

  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  Ground({
    super.position,
    super.anchor,
    Vector2? scale,
  }) : super(
          scale: scale ?? Vector2(2, 2),
        );

  @override
  Future<void> onLoad() async {
    final img = await game.images.load('background/base.png');

    sprite = Sprite(
      img,
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(336, 112),
    );

    hitbox = RectangleHitbox();
    if (game.isDebug) {
      final defaultPaint = Paint()
        ..color = _defaultColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      hitbox.paint = defaultPaint;
      hitbox.renderShape = true;
    }

    add(hitbox);
  }
}
