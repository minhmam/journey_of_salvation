import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:journey_of_salvation/components/player.dart';
import 'package:journey_of_salvation/pixel_adventure.dart';


enum BulletState { normal, pieces }


class Bullet extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  Bullet({
    super.position,
    super.size,
  });

  static const stepTime = 0.08;
  final textureSize = Vector2(36, 34);

  bool gotStomped = false;
  static const double _bounceHeight = 260.0;

  late final Player player;
  late final SpriteAnimation _bulletAnimation;//đạn bình thường
  late final SpriteAnimation _piecesAnimation;//đạn bị vỡ

  double lastShotTime = 0.0;
  double shotCooldown = 1.0;
  bool isShooting = false;

  @override
  FutureOr<void> onLoad() {
    player = game.player;
    add(
      RectangleHitbox(
        position: Vector2(4, 6),
        size: Vector2(24, 26),
      ),
    );
    _loadAllAnimations();
    return super.onLoad();
  }
  @override
  void update(double dt) {
    if (!gotStomped) {
      _updateState(dt);
    }
    super.update(dt);
  }
  void _loadAllAnimations() {
    _bulletAnimation = _createBulletAnimation('Bullet', 1);
    _piecesAnimation = _createBulletAnimation('BulletPieces', 2);

    animations = {
      BulletState.normal: _bulletAnimation,
      BulletState.pieces: _piecesAnimation,
    };

  }

  SpriteAnimation _createBulletAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Enemies/Bee/$state.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: textureSize,
      ),
    );
  }
  void _updateState(double dt) {

  }
  void collidedWithPlayer() async {
    if (!gotStomped) {
      gotStomped = true;
      current = BulletState.pieces;
      await Future.delayed(const Duration(milliseconds: 500));
      removeFromParent();
    }
  }
}



