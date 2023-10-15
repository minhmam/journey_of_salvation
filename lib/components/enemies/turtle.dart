import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../pixel_adventure.dart';
import '../player.dart';

enum State { hit, idle1, idle2, spikesIn, spikesOut }

class Turtle extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  Turtle({
    super.position,
    super.size,
  });

  static const stepTime = 0.05;
  static const tileSize = 16;
  static const runSpeed = 30;
  static const _bounceHeight = 260.0;
  final textureSize = Vector2(44, 26);

  Vector2 velocity = Vector2.zero();
  double rangeNeg = 0;
  double rangePos = 0;
  double moveDirection = 1;
  double targetDirection = -1;
  bool gotStomped = false;
  bool isAttack = true;

  late final Player player;
  late final SpriteAnimation _idle1Animation;
  late final SpriteAnimation _idle2Animation;
  late final SpriteAnimation _spikesInAnimation;
  late final SpriteAnimation _spikesOutAnimation;
  late final SpriteAnimation _hitAnimation;

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    player = game.player;

    add(
      RectangleHitbox(
        position: Vector2(4, 6),
        size: Vector2(36, 20),
      ),
    );
    _loadAllAnimations();
    // _calculateRange();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!gotStomped) {
      _updateState();
    }

    super.update(dt);
  }

  void _loadAllAnimations() {
    _hitAnimation = _spriteAnimation('Hit', 5)..loop = false;
    _idle1Animation = _spriteAnimation('Idle 1', 14);
    _idle2Animation = _spriteAnimation('Idle 2', 14);
    _spikesInAnimation = _spriteAnimation('Spikes in', 8);
    _spikesOutAnimation = _spriteAnimation('Spikes out', 8);

    animations = {
      State.hit: _hitAnimation,
      State.idle1: _idle1Animation,
      State.idle2: _idle2Animation,
      State.spikesIn: _spikesInAnimation,
      State.spikesOut: _spikesOutAnimation,
    };

    current = State.idle1;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Enemies/Turtle/$state (44x26).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: textureSize,
      ),
    );
  }

  bool playerInRange() {
    double playerOffset = (player.scale.x > 0) ? 0 : -player.width;

    return player.x + playerOffset >= rangeNeg &&
        player.x + playerOffset <= rangePos &&
        player.y + player.height > position.y &&
        player.y < position.y + height;
  }

  void _updateState() {
    if (isAttack) {
      current = State.idle1;
      Future.delayed(const Duration(seconds: 4), () {
        current = State.spikesIn;
        Future.delayed(const Duration(microseconds: 400), () {
          isAttack = false;
          current = State.idle2;
        });
      });
    } else {
      current = State.idle2;
      Future.delayed(const Duration(seconds: 10), () {
        current = State.spikesOut;
        Future.delayed(const Duration(microseconds: 400), () {
          isAttack = true;
          current = State.idle1;
        });
      });
    }
  }

  void collidedWithPlayer() async {
    if (!isAttack) {
      if (player.velocity.y > 0 && player.y + player.height > position.y) {
        if (game.playSounds) {
          FlameAudio.play('bounce.wav', volume: game.soundVolume);
        }
        gotStomped = true;
        current = State.hit;
        player.velocity.y = -_bounceHeight;
        await animationTicker?.completed;
        removeFromParent();
      } else {
        player.collidedwithEnemy();
      }
    } else {
      player.collidedwithEnemy();
    }
  }
}
