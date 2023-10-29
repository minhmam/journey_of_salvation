import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';


class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.center, children: [
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal! * 8 * 1.0 * 20,
                    width: SizeConfig.blockSizeHorizontal! * 8 * 1.0 * 10,
                    // child: GameWidget(
                    //   game: PixelAdventure(),
                    // ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}