import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/painting.dart';
import 'package:journey_of_salvation/components/jump_button.dart';
import 'package:journey_of_salvation/components/level.dart';
import 'package:journey_of_salvation/components/player.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showControls = true;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = ['Level01-2', 'Level-01'];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    _loadLevel();
    if (showControls) {
      addJoystick();
    }

    addAll([
      JumpButton(),
    ]);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
        size: Vector2(128, 128),
      ),
      margin: const EdgeInsets.only(left: 52, bottom: 52),
    );
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    removeWhere((component) => component is Level);

    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {
      // no more levels
      currentLevelIndex = 0;
      _loadLevel();
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration(seconds: 1), () {
      Level world = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );


      cam = CameraComponent.withFixedResolution(
        world: world,
        width: 640,
        height: 390,
      );
      // cam.viewport.size = Vector2(640, 360);
      cam.viewfinder.anchor = Anchor.topLeft;
      // cam.viewport.position = Vector2(144, 480);
      // cam.viewfinder.position = Vector2(144, 480);
      // // cam.viewport.size = Vector2(640, 360);
      // cam.viewport.position = Vector2(144, 480);
      // cam.viewfinder.visibleGameSize = Vector2(640, 360);

      // cam.viewfinder.anchor = Anchor.center;

      // cam = CameraComponent(world: world)
      //   // ..viewport.size = Vector2(30, 10)
      //   ..viewport.position = Vector2(-144, -480);
        // ..viewfinder.visibleGameSize = Vector2(640, 360)
        // ..viewfinder.position = Vector2(144, 480);
        // ..viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);
    });
  }
}
