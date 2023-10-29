import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
class ChooseCharacter extends StatefulWidget {
  const ChooseCharacter({super.key});

  @override
  State<ChooseCharacter> createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<ChooseCharacter> {
  final myitems = [
    Image.asset('assets/images/image/mask.gif'),
    Image.asset('assets/images/image/Ninja frog.jpg'),
    Image.asset('assets/images/image/Pink man.jpg'),
    Image.asset("assets/images/image/Virtual gay.jpg"),
  ];

  int myCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
          title: const Text('Auto Image Slider'),
          centerTitle: true,
          elevation: 3,
          backgroundColor: Colors.grey.shade800,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      myCurrentIndex = index;
                    });
                  },
                ),
                items: myitems,
              ),
              AnimatedSmoothIndicator(activeIndex: myCurrentIndex,
                count: myitems.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 10,
                  dotColor: Colors.grey.shade200,
                  activeDotColor: Colors.grey.shade900,
                  paintStyle: PaintingStyle.fill,
                ),)
            ],
          ),
        ));
  }
}