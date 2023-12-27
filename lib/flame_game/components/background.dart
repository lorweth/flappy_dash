import 'package:flame/components.dart';

class Background extends SpriteComponent {
  Background({
    super.position,
    super.size,
    super.scale,
    super.anchor,
  });

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('background/Background2.png');
  }
}
