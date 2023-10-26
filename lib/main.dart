import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_of_salvation/pixel_adventure.dart';
import 'package:journey_of_salvation/screen/level.dart';
import 'package:journey_of_salvation/screen/pageGame.dart';
import 'package:journey_of_salvation/screen/route.dart';

import 'screen/mainMenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    // runApp(GameWidget(game: RouterGame()));
    runApp(MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        '/second': (context) => const SecondScreen(),
        '/level2': (context) => GameWidget(game: PixelAdventure()),
        '/playScreen': (context) => const PlayScreen(),
      },
    ));
  });
}
