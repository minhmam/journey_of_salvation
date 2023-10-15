
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:journey_of_salvation/screen/pageGame.dart';
import '../pixel_adventure.dart';
import 'home.dart';
import 'level.dart';

class RouterGame extends FlameGame {
  late final RouterComponent router;
  late final SpriteComponent background;

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load('Menu/background.jpg');
    background = SpriteComponent(
      sprite: sprite,
      size: Vector2(size.x, size.y),
    );
    //convert PixelAdventure to GameWidget


    addAll([
      background,
      router = RouterComponent(
        routes: {
          "home": Route(HomePage.new),
          "level1": Route(Level1Page.new),
          "level2":  Route(()=> PixelAdventure()),
        },
        initialRoute: 'home',

      ),]
    );
  }
}