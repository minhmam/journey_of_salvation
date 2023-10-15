import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import '../components/utils.dart';

class Level1Page extends Component {
  @override
  Future<void> onLoad() async {
    final game = findGame()!;
    addAll([
      Background(const Color(0xbb2a074f)),
      BackButton(),
      Planet(
        radius: 25,
        color: const Color(0xfffff188),
        position: game.size / 2,
        children: [
          Orbit(
            radius: 110,
            revolutionPeriod: 6,
            planet: Planet(
              radius: 10,
              color: const Color(0xff54d7b1),
              children: [
                Orbit(
                  radius: 25,
                  revolutionPeriod: 5,
                  planet: Planet(radius: 3, color: const Color(0xFFcccccc)),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}