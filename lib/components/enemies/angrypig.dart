import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../pixel_adventure.dart';
import '../player.dart';

enum State { hit1, hit2, idle, run, walk }

class AngryPig extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  final double offNeg;
  final double offPos;

  AngryPig({
    super.position,
    super.size,
    this.offNeg = 0,
    this.offPos = 0,
  });

  static const stepTime = 0.05;
  static const tileSize = 16;
  static const walkSpeed = 35;
  static const runSpeed = 120;
  static const _bounceHeight = 260.0;
  final textureSize = Vector2(36, 30);

  Vector2 velocity = Vector2.zero();
  double rangeNeg = 0;
  double rangePos = 0;
  double moveDirection = 1;
  double targetDirection = -1;
  bool gotStomped = false;
  bool isHitOne = false;

  late final Player player;
  late final SpriteAnimation _hit1Animation;
  late final SpriteAnimation _hit2Animation;
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _walkAnimation;

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    player = game.player;

    add(
      RectangleHitbox(
        position: Vector2(2, 0),
        size: Vector2(36, 30),
      ),
    );
    _loadAllAnimations();
    _calculateRange();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!gotStomped) {
      _updateState();
      _movement(dt);
    }

    super.update(dt);
  }

  void _loadAllAnimations() {
    _hit1Animation = _spriteAnimation('Hit 1', 5)..loop = false;
    _hit2Animation = _spriteAnimation('Hit 2', 5)..loop = false;
    _idleAnimation = _spriteAnimation('Idle', 9);
    _runAnimation = _spriteAnimation('Run', 12);
    _walkAnimation = _spriteAnimation('Walk', 16);

    animations = {
      State.hit1: _hit1Animation,
      State.hit2: _hit2Animation,
      State.idle: _idleAnimation,
      State.run: _runAnimation,
      State.walk: _walkAnimation,
    };

    current = State.walk;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Enemies/AngryPig/$state (36x30).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: textureSize,
      ),
    );
  }

  void _calculateRange() {
    rangeNeg = position.x - offNeg * tileSize;
    rangePos = position.x + offPos * tileSize;
  }

  void _movement(dt) {
    if (position.x >= rangePos) {
      moveDirection = -1;
    } else if (position.x <= rangeNeg) {
      moveDirection = 1;
    }
    if (isHitOne) {
      position.x += moveDirection * runSpeed * dt;
    } else {
      position.x += moveDirection * walkSpeed * dt;
    }
  }

  bool playerInRange() {
    double playerOffset = (player.scale.x > 0) ? 0 : -player.width;

    return player.x + playerOffset >= rangeNeg &&
        player.x + playerOffset <= rangePos &&
        player.y + player.height > position.y &&
        player.y < position.y + height;
  }

  void _updateState() {
    if (isHitOne) {
      current = (velocity.x != 0) ? State.run : State.run;
    } else {
      current = (velocity.x != 0) ? State.walk : State.walk;
    }

    if ((moveDirection > 0 && scale.x > 0) ||
        (moveDirection < 0 && scale.x < 0)) {
      flipHorizontallyAroundCenter();
    }
  }

  void collidedWithPlayer() async {
    if (player.velocity.y > 0 &&
        player.y + player.height > position.y &&
        !isHitOne) {
      isHitOne = true;
      if (game.playSounds) {
        FlameAudio.play('bounce.wav', volume: game.soundVolume);
      }
      current = State.hit1;
      player.velocity.y = -_bounceHeight;
      await animationTicker?.completed;
    } else if (player.velocity.y > 0 &&
        player.y + player.height > position.y &&
        isHitOne) {
      if (game.playSounds) {
        FlameAudio.play('bounce.wav', volume: game.soundVolume);
      }
      gotStomped = true;
      current = State.hit1;
      player.velocity.y = -_bounceHeight;
      await animationTicker?.completed;
      removeFromParent();
    } else {
      player.collidedwithEnemy();
    }
  }
}
