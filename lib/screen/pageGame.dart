import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import '../components/utils.dart';
import '../pixel_adventure.dart';

class PageGame extends Component {
  @override
  Future<void> onLoad() async {
    addAll([
      // GameWidget(game: PixelAdventure()),
    ]);
  }
}