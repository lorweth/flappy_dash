import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/flame_game/components/obstacle.dart';
import 'package:flappy_dash/flame_game/effects/hurt_effect.dart';
import 'package:flappy_dash/flame_game/effects/jump_effect.dart';
import 'package:flappy_dash/flame_game/flappy_dash.dart';
import 'package:flappy_dash/flame_game/flappy_dash_world.dart';

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with
        CollisionCallbacks,
        HasWorldReference<FlappyDashWorld>,
        HasGameReference<FlappyDash> {
  // The maximum length that the player can jump. Defined in virtual pixels.
  final double _jumpLength = 400;

  // Used to store the last height of the player, so that we later can
  // determine which direction that the player is moving.
  double _lastHeight = 0;

  // When the player has velocity pointing downwards it is counted as falling,
  // this is used to set the correct animation for the player.
  bool get isFalling => _lastHeight < position.y;

  bool get isJumping => _lastHeight > position.y;

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
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2.all(16),
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

    // Calculate new Y-axis after gravity effect
    position.y += world.gravity * dt * 100;

    // When player falling
    if (isFalling) {
      current = PlayerState.falling;
    }

    // When player jumping
    if (isJumping) {
      current = PlayerState.jumping;
    }

    final belowGround = position.y + size.y / 2 > world.groundLevel;
    // If the player's new position would overshoot the ground level after
    // updating its position we need to move the player up to the ground level
    // again.
    if (belowGround) {
      position.y = world.groundLevel - size.y / 2;
      current = PlayerState.running;
    }

    _lastHeight = position.y;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    // When the player collides with an obstacle it should lose all its points.
    if (other is Obstacle) {
      // game.audioController.playSfx(SfxType.damage);
      // resetScore();
      add(HurtEffect());
    }
  }

  void jump() {
    if (position.y + size.y / 2 > world.skyLevel) {
      final jumpEffect = JumpEffect(Vector2(0, -1)..scaleTo(_jumpLength));
      add(jumpEffect);
    }
  }
}

enum PlayerState {
  running,
  jumping,
  falling,
}
