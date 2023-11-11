import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/widgets.dart';
import 'package:journey_of_salvation/components/model/level.dart';

import '../components/database/level_db.dart';

class MainMenuWidget extends StatefulWidget {
  const MainMenuWidget({Key? key}) : super(key: key);
  @override
  MainMenu createState() => MainMenu();
}

class MainMenu extends State<MainMenuWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
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
              child: PlayButton(
                volume: volume,
              )
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
              child: StoreButton(
                volume: volume,
              )
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    playBackgroundMusic();
  }

  void playBackgroundMusic() async {
    await FlameAudio.audioCache.load("Backgrourd_music.wav");
    if (volume) FlameAudio.bgm.play('Backgrourd_music.wav', volume: 1.0 );

  }


}
class PlayButton extends StatelessWidget {
  final bool volume;
  const PlayButton({super.key,
    required this.volume,});

  @override
  Widget build(BuildContext context) {
    return SpriteButton.asset(
      path: "Menu/Buttons/Play.png",
      onPressed: () {
        if(volume)FlameAudio.play('click.wav');
        Navigator.pushNamed(context, '/level2');
      },
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      label:  const Text('' ),
      pressedPath: "Menu/Buttons/Play.png",
    );
  }
}



class StoreButton extends StatelessWidget{
  final bool volume;
  const StoreButton({super.key,
    required this.volume,});

  @override
  Widget build(BuildContext context){
    return SpriteButton.asset(
      path: "Menu/Buttons/Icon_Cart.png",
      onPressed: () {
        if(volume)FlameAudio.play('click.wav');
        Navigator.pushNamed(context, '/choose_character');
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
      onPressed: () async {
        if(volume)FlameAudio.play('click.wav');
        onVolumeChanged(!volume);
        if (volume) {
          FlameAudio.bgm.pause();
        } else {
          FlameAudio.bgm.resume();
        }
      },
      width: MediaQuery.of(context).size.width * 0.05,
      height: MediaQuery.of(context).size.height * 0.1,
      label:  const Text(''),
      pressedPath: "Menu/Buttons/SoundOn.png",
    );
  }

  void insertTest() {
    Level level = Level(1, 'Level-01');

    //insert level
    LevelDB().insert(level.toMap());

    //fetch all
    LevelDB().fetchAll().then((value) => print(value));
  }
}
