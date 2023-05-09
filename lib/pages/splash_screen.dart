import 'package:discover_your_home/consts.dart';
import 'package:discover_your_home/pages/home_page.dart';
import 'package:discover_your_home/widgets/fade_in_animation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: black,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            FadeInAnimation(
              animatePosition: MyAnimation(
                topAfter: -150,
                topBefore: -150,
                leftAfter: -650,
                leftBefore: -800,
                bottomAfter: -150,
                bottomBefore: -150,
              ),
              delayInMs: 1000,
              durationInMs: 2500,
              child: GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: Image.asset(
                  'assets/images/earth_home.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 40,
              child: RichText(
                  text: TextSpan(
                      style: proportional.copyWith(fontSize: 48),
                      children: [
                    const TextSpan(text: 'discover your '),
                    TextSpan(
                        text: 'home',
                        style: proportional.copyWith(color: blue)),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
