import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:journey_of_salvation/screen/route.dart';
import 'package:flutter/painting.dart'; // Import Offset from the Flutter package

class HomePage extends FlameGame with HasTappables, HasGameRef<RouterGame> {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  late ButtonSetting settingBtn;
  // ButtonSetting buttonSetting = ButtonSetting();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    settingBtn= ButtonSetting()
      ..sprite = await loadSprite("Menu/Buttons/Play.png")
      ..size = Vector2(64, 64)
      ..position = Vector2(size.x / 2 - 64 / 2, size.y / 2 - 64 / 2);


    background
      ..sprite = await loadSprite('Menu/background.jpg')
      ..size = Vector2(size.x, size.y);

    // button settings


    // buttonSetting
    //   ..sprite = await loadSprite("Menu/Buttons/Play.png")
    //   ..size = Vector2(64, 64)
    //   ..position = Vector2(size.x / 2 - 64 / 2, size.y / 2 - 64 / 2);

    addAll([
      background,
      settingBtn,
    ]);
  }
  void navigateToSetting() {
    gameRef.router.pushNamed('setting');
  }
}


class ButtonSetting extends SpriteComponent with Tappable, HasGameRef<RouterGame> {
  @override
  bool onTapup(TapDownInfo event) {
    print("mute");
    return true;
  }
}

