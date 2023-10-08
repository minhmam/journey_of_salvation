import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:journey_of_salvation/components/player.dart';
import 'package:journey_of_salvation/pixel_adventure.dart';

import 'bullet.dart';
enum BeeState { idle, attack, hit }
enum BulletState { normal, pieces }


class Bee extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  Bee({
    super.position,
    super.size,
  });

  static const stepTime = 0.08;
  final textureSize = Vector2(36, 34);

  bool gotStomped = false;
  static const double _bounceHeight = 260.0;

  late final Player player;
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _attackAnimation;
  late final SpriteAnimation _hitAnimation;

  double lastShotTime = 0.0;
  double shotCooldown = 1.0;
  bool isShooting = false;

  @override
  FutureOr<void> onLoad() {
    player = game.player;
    add(
      RectangleHitbox(
        position: Vector2(4, 6),
        size: Vector2(16, 16),
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
    _idleAnimation = _spriteAnimation('Idle', 6);
    _attackAnimation = _spriteAnimation('Attack', 8);
    _hitAnimation = _spriteAnimation('Hit', 5);

    animations = {
      BeeState.idle: _idleAnimation,
      BeeState.attack: _attackAnimation,
      BeeState.hit: _hitAnimation,
    };

    current = BeeState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Enemies/Bee/$state (36x34).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: textureSize,
      ),
    );
  }
  void _updateState(double dt) {
    // const timemOutDetlay = Duration(milliseconds: 10000);
    final distance = (player.x - x).abs();
    if (current == BeeState.idle) {
      if (distance < 150) {
        current = BeeState.attack;
      }
    } else{
      if (distance > 150) {
        current = BeeState.idle;
      }
    }

    if (current == BeeState.attack) {
      if (player.x < x) {
        scale.x = -1;
      } else {
        scale.x = 1;
      }
      if (player.x < x && !isShooting) {
        isShooting = true;
        _shootBurst();
      }
      if (player.x > x && !isShooting) {
        isShooting = true;
        _shootBurst();
      }
    }
  }
  void _shootBurst() {
    // Create and add a new bullet to the game world
    const timemOutDetlay = Duration(milliseconds: 10000);
    final bullet = Bullet()
      ..x = this.x // Set the bullet's initial x position
      ..y = this.y // Set the bullet's initial y position
      ..current = BulletState.normal; // Set the bullet state to normal

    game.add(bullet);

    // Check the distance between the player and the bee
    final distance = (player.x - x).abs();
    const double cellSize = 32.0;

    // If the distance is greater than 4 cells, set the bullet state to attacking
    if (distance > 4 * cellSize) {
      bullet.current = BulletState.pieces; // Set bullet state to attacking
      // Calculate the direction of the bullet based on player's position
      final direction = player.x < x ? -1 : 1;
      // Move the bullet 4 cells away in the calculated direction
      bullet.x += 4 * cellSize * direction;
    }
    // Schedule the bullet to move after a delay
    Future.delayed(timemOutDetlay, () {
      bullet.current = BulletState.pieces;
    });
  }
  void collidedWithPlayer() async {
    if (player.velocity.y > 0 && player.y + player.height > position.y) {
      gotStomped = true;
      current = BeeState.hit;
      player.velocity.y = -_bounceHeight;
      await animationTicker?.completed;
      removeFromParent();
    } else {
      player.collidedwithEnemy();
    }
  }
}



