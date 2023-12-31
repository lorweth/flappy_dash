import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/flame_game/flappy_dash.dart';
import 'package:flutter/material.dart';

/// abstract class [Point] add score point when colliding with [Player]
abstract class Point {}

class ScorePoint extends PositionComponent
    with HasGameRef<FlappyDash>
    implements Point {
  final _defaultColor = Colors.green;
  late ShapeHitbox hitbox;

  ScorePoint({
    super.position,
    super.anchor,
    super.size,
  });

  @override
  Future<void> onLoad() async {
    hitbox = RectangleHitbox();
    if (game.isDebug) {
      final defaultPaint = Paint()
        ..color = _defaultColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5;

      hitbox.paint = defaultPaint;
      hitbox.renderShape = true;
    }

    add(hitbox);
  }
}
