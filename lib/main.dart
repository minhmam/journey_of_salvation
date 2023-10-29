import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_of_salvation/pixel_adventure.dart';
import 'package:journey_of_salvation/screen/level.dart';
import 'package:journey_of_salvation/screen/pageGame.dart';
import 'package:journey_of_salvation/screen/splash.dart';

import 'screen/mainMenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(
          seconds: 3,
          navigateAfterSeconds: MainMenuWidget(),
          title: Text(
            'Journey of Salvation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          styleTextUnderTheLoader: TextStyle(),
          loaderColor: Colors.white,
        ),
        '/settingScreen': (context) => const SecondScreen(),
        '/level2': (context) => GameWidget(game: PixelAdventure()),
        '/choose_character': (context) => const ChooseCharacter(),
      },
    ));
  });
}

