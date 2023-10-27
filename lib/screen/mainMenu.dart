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
            Positioned(
              left: MediaQuery.of(context).size.width * 0.6 - MediaQuery.of(context).size.width * 0.15,
              top: MediaQuery.of(context).size.height * 0.6 - MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.6 - MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.6 - MediaQuery.of(context).size.width * 0.15,
              child: PlayButton(),
            ),
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
          ],
        ),
      ),
    );
  }
}

class PlayButton extends StatefulWidget {
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
      label: const Text(""),
      pressedPath: "Menu/Buttons/Play.png",
    );
  }
}

class VolumeButton extends StatelessWidget {
  final bool volume;
  final Function(bool) onVolumeChanged;

  VolumeButton({
    required this.volume,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SpriteButton.asset(
      path: volume ? "Menu/Buttons/Audio1.png" : "Menu/Buttons/Audio2.png",
      onPressed: () {
        onVolumeChanged(!volume);
      },
      width: MediaQuery.of(context).size.width * 0.05,
      height: MediaQuery.of(context).size.height * 0.1,
      label: const Text(""),
      pressedPath: "Menu/Buttons/Audio1.png",
    );
  }
}
