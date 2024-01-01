import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_dash/flame_game/components/pipe.dart';
import 'package:flappy_dash/flame_game/flappy_dash_world.dart';

class Wall extends PositionComponent with HasWorldReference<FlappyDashWorld> {
  final Random _random = Random();

  Wall({Vector2? position})
      : super(
          position: position ?? Vector2(0, 0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    const pipeImage = 'pipe/PipeStyle1.png';

    final components = [
      Pipe(
        image: pipeImage,
        anchor: Anchor.center,
        position: Vector2(0, -world.size.y/2),
        scale: 3,
      ),
      Pipe(
        image: pipeImage,
        anchor: Anchor.center,
        position: Vector2(0, world.size.y/5),
        scale: 3,
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
    position.x -= world.speed * dt;

    if (position.x < -(world.size.x / 2)) {
      position.x = world.size.x;
      position.y = _random.nextDouble() * 204;
    }
  }
}
