import 'dart:js';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_of_salvation/pixel_adventure.dart';
import 'package:journey_of_salvation/screen/level.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(GameWidget(game: MainMenu()));
  });
}

class MainMenu extends FlameGame with HasTappables {
  PlayButton dialogButton = PlayButton();
  late Vector2 buttonPlaySize;

  @override
  Future<void> onLoad() async {
    // Get the screen size
    final screenSize = Vector2(size.x, size.y);

    // Calculate the button size as a fraction of the screen size
    buttonPlaySize = screenSize / 4.5;

    final background = await loadSprite('Menu/background.jpg');
    final backgroundComponent = SpriteComponent(
      sprite: background,
      size: screenSize,
    );
    add(backgroundComponent);

    final settingBtn = await loadSprite('Menu/Buttons/Settings.png');
    final titleComponent = SpriteComponent(
      sprite: settingBtn,
      size: Vector2(34, 34),
      position: Vector2(24, size.y - 54),
    );
    add(titleComponent);

    final volumeBtn = await loadSprite('Menu/Buttons/volume.png');
    final volumeButtonComponent = SpriteComponent(
      sprite: volumeBtn,
      size: Vector2(34, 34),
      position: Vector2(64, size.y - 54),
    );
    add(volumeButtonComponent);

    buttonPlay();
  }

  void buttonPlay() async {
    dialogButton
      ..sprite = await loadSprite("Menu/Buttons/Play.png")
      ..size = buttonPlaySize
      ..position = Vector2(size.x / 2 - buttonPlaySize.x / 2, size.y / 2 - buttonPlaySize.y / 2);
    add(dialogButton);
  }

  void openLevelSelectionScreen() {
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => LevelSelectionScreen()),
    );
  }
}

class PlayButton extends SpriteComponent with Tappable {
  MainMenu? game;

  @override
  bool onTapDown(TapDownInfo info) {
    game!.openLevelSelectionScreen();
    return true;
  }
}
