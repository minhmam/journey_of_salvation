import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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