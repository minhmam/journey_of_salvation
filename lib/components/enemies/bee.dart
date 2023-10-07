import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../pixel_adventure.dart';

class Bee extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {}
