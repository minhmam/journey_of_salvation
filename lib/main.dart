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
      initialRoute: '/', // Use initialRoute instead of home
      routes: {
        '/': (context) => const SplashScreen(
          seconds: 5,
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
        '/playScreen': (context) => const PlayScreen(),
      },
    ));

  });
}

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Widget navigateAfterSeconds;
  final Text title;
  final Image? image;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic onClick;
final double photoSize;
final Color? loaderColor;

  const SplashScreen(
      {Key? key,
        required this.seconds,
        required this.navigateAfterSeconds,
        this.title = const Text(''),
        this.image,
        this.backgroundColor = Colors.white,
        this.styleTextUnderTheLoader = const TextStyle(),
        this.photoSize = 100.0,
        this.onClick,
        this.loaderColor})
      : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Future.delayed(Duration(seconds: widget.seconds), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => widget.navigateAfterSeconds));
    });
  }

  @override
  Widget build(BuildContext context) {
    //show icon at center
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: InkWell(
        onTap: widget.onClick,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  child: widget.image,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Text(
                  widget.title.data.toString(),
                  style: widget.styleTextUnderTheLoader,
                ),
                //icon
                // Image.asset(
                //   'Menu/Buttons/logo.png',
                //   width: 100,
                //   height: 100,
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  color: widget.loaderColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}