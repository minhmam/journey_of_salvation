import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/widgets.dart';

class MainMenuWidget extends StatefulWidget {
  const MainMenuWidget({Key? key}) : super(key: key);
  @override
  MainMenu createState() => MainMenu();
}

class MainMenu extends State<MainMenuWidget> {
  bool volume = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/Menu/background_game.gif"), fit: BoxFit.fill),
              ),
            ),
            //button play
            Positioned(
              left: MediaQuery.of(context).size.width * 0.6 - MediaQuery.of(context).size.width * 0.15,
              top: MediaQuery.of(context).size.height * 0.6 - MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.6 - MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.6 - MediaQuery.of(context).size.width * 0.15,
              child: const PlayButton(),
            ),
            //button volume
            Positioned(
              left: MediaQuery.of(context).size.width * 0.08 - MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.16 - MediaQuery.of(context).size.width * 0.05,
              child: VolumeButton(
                onVolumeChanged: (bool newVolume) {
                  setState(() {
                    volume = newVolume;
                  });
                },
                volume: volume,
              ),
            ),
            //button cart
            Positioned(
              left: MediaQuery.of(context).size.width * 0.16 - MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.16 - MediaQuery.of(context).size.width * 0.05,
              child: const StoreButton(),
            ),
          ],
        ),
      ),
    );
  }
}
class PlayButton extends StatefulWidget {
  const PlayButton({super.key});

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return SpriteButton.asset(
      path: "Menu/Buttons/Play.png",
      onPressed: () {
        Navigator.pushNamed(context, '/level2');
      },
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      label:  const Text('' ),
      pressedPath: "Menu/Buttons/Play.png",
    );
  }
}

class StoreButton extends StatefulWidget {
  const StoreButton({super.key});
  @override
  StoreButtonState createState() => StoreButtonState();
}
class StoreButtonState extends State<StoreButton> {
  @override
  Widget build(BuildContext context) {
    return SpriteButton.asset(
      path: "Menu/Buttons/Icon_Cart.png",
      onPressed: () {
        Navigator.pushNamed(context, '/');
      },
      width: MediaQuery.of(context).size.width * 0.05,
      height: MediaQuery.of(context).size.height * 0.1,
      label:  const Text(''),
      pressedPath: "Menu/Buttons/Icon_Cart.png",
    );
  }
}


class VolumeButton extends StatelessWidget {
  final bool volume;
  final Function(bool) onVolumeChanged;

  const VolumeButton({super.key,
    required this.volume,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SpriteButton.asset(
      path: volume ? "Menu/Buttons/SoundOn.png" : "Menu/Buttons/SoundOff.png",
      onPressed: () {
        onVolumeChanged(!volume);
      },
      width: MediaQuery.of(context).size.width * 0.05,
      height: MediaQuery.of(context).size.height * 0.1,
      label:  const Text(''),
      pressedPath: "Menu/Buttons/SoundOn.png",
    );
  }
}
