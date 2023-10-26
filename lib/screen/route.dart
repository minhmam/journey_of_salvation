
// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
// import 'package:journey_of_salvation/screen/mainMenu.dart';
// import '../pixel_adventure.dart';
// import 'home.dart';
// import 'level.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../pixel_adventure.dart';
import 'home.dart';
import 'level.dart';
import 'mainMenu.dart';

class RouterGame extends FlameGame {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    addAll([

      router = RouterComponent(
        routes: {
          // "home": Route(HomePage.new),
          // "level1": Route(Level1Page.new),
          // "level2":  widgetFactory(PixelAdventure.new),
          // "mainMenu": Route(MainMenu.new),
        },
        initialRoute: 'mainMenu',
      ),
    ]
    );
  }
}