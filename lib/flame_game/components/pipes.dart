import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_dash/flame_game/components/pipe.dart';

class Pipes extends PositionComponent {
  final Vector2 worldSize;
  final double worldSpeed;
  final double worldGroundLevel;

  final double _scale;

  final Random _random = Random();

  Pipes({
    super.position,
    super.anchor,
    required this.worldSize,
    required this.worldSpeed,
    required this.worldGroundLevel,
    double? scale
  }): _scale = scale ?? 1;

  @override
  Future<void> onLoad() async {
    const pipeImage = 'pipe/PipeStyle1.png';

    final components = [
      Pipe(
        image: pipeImage,
        anchor: Anchor.bottomCenter,
        position: Vector2(0, -worldSize.y / 7),
        scale: _scale,
      ),
      Pipe(
        image: pipeImage,
        anchor: Anchor.topCenter,
        position: Vector2(0, worldSize.y / 8),
        scale: _scale,
      )
    ];

    addAll(components);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // We need to move the component to the left together with the speed that we
    // have set for the world.
    // `dt` here stands for delta time and it is the time, in seconds, since the
    // last update ran. We need to multiply the speed by `dt` to make sure that
    // the speed of the obstacles are the same no matter the refresh rate/speed
    // of your device.
    position.x -= worldSpeed * dt;

    if (position.x <= -(worldSize.x / 2)) {
      position.x = worldSize.x;

      final maxHeight = -worldSize.y / 4;
      final minHeight = worldGroundLevel/2;
      position.y = (_random.nextDouble() * (maxHeight - minHeight)) + minHeight;
    }
  }
}
