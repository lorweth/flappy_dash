import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/flame_game/flappy_dash.dart';
import 'package:flappy_dash/flame_game/flappy_dash_world.dart';

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with
        CollisionCallbacks,
        HasWorldReference<FlappyDashWorld>,
        HasGameReference<FlappyDash> {

  // Constructor
  Player({
    super.position,
  }) : super(
    size: Vector2.all(150),
    anchor: Anchor.center,
    priority: 1,
  );

  @override
  Future<void> onLoad() async {
    // This defines the different animation states that the player can be in.
    animations = {
      PlayerState.running: await game.loadSpriteAnimation(
        'dash/dash_running.png',
        SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.15, textureSize: Vector2.all(16),
        ),
      ),
      PlayerState.jumping: SpriteAnimation.spriteList(
        [await game.loadSprite('dash/dash_jumping.png')],
        stepTime: double.infinity,
      ),
      PlayerState.falling: SpriteAnimation.spriteList(
        [await game.loadSprite('dash/dash_falling.png')],
        stepTime: double.infinity,
      ),
    };

    // The starting state will be that the player is running.
    current = PlayerState.running;

    // When adding a CircleHitbox without any arguments it automatically
    // fills up the size of the component as much as it can without overflowing
    // it.
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

}

enum PlayerState {
  running,
  jumping,
  falling,
}
