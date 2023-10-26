import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:journey_of_salvation/screen/route.dart';
import 'package:flutter/painting.dart'; // Import Offset from the Flutter package

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);
  // SpriteComponent girl = SpriteComponent();
  // SpriteComponent boy = SpriteComponent();
  // SpriteComponent background = SpriteComponent();
  // late ButtonSetting settingBtn;
  // ButtonSetting buttonSetting = ButtonSetting();

  // @override
  // Future<void> onLoad() async {
  //
  //   // settingBtn= ButtonSetting(
  //   //   action: () => game.router.pushNamed('level2'),
  //   // )
  //   //   ..sprite = await loadSprite("Menu/Buttons/Settings.png")
  //   //   ..size = Vector2(34, 34)
  //   //   ..position = Vector2(24, size.y - 54);
  //   // buttonSetting
  //   //   ..sprite = await loadSprite("Menu/Buttons/Play.png")
  //   //   ..size = Vector2(64, 64)
  //   //   ..position = Vector2(size.x / 2 - 64 / 2, size.y / 2 - 64 / 2);
  //   background
  //     ..sprite = await loadSprite('Menu/background.jpg')
  //     ..size = Vector2(size.x, size.y);
  //   addAll([
  //     background,
  //     settingBtn,
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: SpriteButton.asset(
          path: "Menu/Buttons/Settings.png",
          onPressed: () =>{
            Navigator.pushNamed(context, '/level2'),
            print('Pressed')
          }
          ,
          width: 34,
          height: 34,
          label: const Text(""),
          pressedPath: "Menu/Buttons/Settings.png",

        ),
          // SpriteButton.asset(path: "Menu/Buttons/Settings.png", pressedPath: "Menu/Buttons/Settings.png", onPressed: ()=>{
          //   Navigator.pushNamed(context, '/second'),
          //   print('Pressed')
          // }, width: 34, height: 34, label: const Text("")),

      ),
    );
  }
}


class ButtonSetting extends SpriteComponent with TapCallbacks{
  ButtonSetting({
    required this.action,
}) : super(priority: 2);
  final void Function() action;


  @override
  void onTapUp(TapUpEvent event) {
    print("mute");
    // gameRef.router.pushNamed('level2');
    scale = Vector2.all(1.0);
    action();
  }
}

