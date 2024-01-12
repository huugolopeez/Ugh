import 'package:flame/components.dart';
import 'package:iugh/games/IughGame.dart';

class JetPlayer extends SpriteAnimationComponent
    with HasGameRef<IughGame> {
  JetPlayer({
    required super.position,
  }) : super(size: Vector2.all(32), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('jet.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }
}