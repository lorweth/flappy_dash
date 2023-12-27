import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// abstract class [Point] add score point when colliding with [Player]
abstract class Point {}

class ScorePoint extends PositionComponent implements Point {
  final _defaultColor = Colors.green;
  late ShapeHitbox hitbox;

  ScorePoint({
    super.position,
    super.anchor,
    super.size,
  });

  @override
  Future<void> onLoad() async {
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;

    add(hitbox);
  }
}
