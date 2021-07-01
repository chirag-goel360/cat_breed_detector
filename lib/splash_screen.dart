import 'package:cat_breed_detector/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 7,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Cat Breed Detector',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.red,
        ),
      ),
      image: Image.asset(
        'assets/cat.gif',
      ),
      backgroundColor: Colors.blue.shade50,
      photoSize: 100,
      loaderColor: Colors.green,
      loadingText: Text(
        'From Chirag Goel',
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16,
        ),
      ),
    );
  }
}
