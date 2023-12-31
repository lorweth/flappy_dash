import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_dash/flame_game/components/obstacle.dart';
import 'package:flappy_dash/flame_game/flappy_dash.dart';
import 'package:flutter/material.dart';

class Pipe extends PositionComponent
    with HasGameReference<FlappyDash>
    implements Obstacle {
  final String image;
  final Vector2 _srcSize;
  final Vector2 _srcPos;
  final double _scale;

  final Vector2 _worldSize;

  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  Pipe({
    required this.image,
    super.position,
    super.anchor,
    Vector2? srcSize,
    Vector2? srcPos,
    Vector2? worldSize,
    double? scale,
  })  : _srcSize = srcSize ?? Vector2(32, 20),
        _srcPos = srcPos ?? Vector2(0, 0),
        _worldSize = worldSize ?? Vector2(750, 1200),
        _scale = scale ?? 1;

  @override
  Future<void> onLoad() async {
    final spriteBatch = await SpriteBatch.load(image);

    final pipeLength = (_worldSize.y) / (_srcSize.y * _scale);

    // Add Pipe top head
    spriteBatch.add(
      source: Rect.fromLTWH(_srcPos.x, _srcPos.y, _srcSize.x, _srcSize.y),
      scale: _scale,
    );

    // Add Pipe body
    for (var i = 1; i < pipeLength - 1; i++) {
      spriteBatch.add(
        source: Rect.fromLTWH(
            _srcPos.x, (_srcPos.y + _srcSize.y), _srcSize.x, _srcSize.y),
        offset: Vector2(0, (_srcSize.y * _scale * i).toDouble()),
        scale: _scale,
      );
    }

    // Add Pipe bottom head
    spriteBatch.add(
      source: Rect.fromLTWH(
          _srcPos.x, (_srcPos.y + 3 * _srcSize.y), _srcSize.x, _srcSize.y),
      offset: Vector2(0, (_srcSize.y * _scale * (pipeLength - 1)).toDouble()),
      scale: _scale,
    );

    add(SpriteBatchComponent(
      spriteBatch: spriteBatch,
    ));

    // Calculate component size
    size = Vector2(_srcSize.x * _scale, _srcSize.y * _scale * pipeLength);

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
