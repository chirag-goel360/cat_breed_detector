import 'package:cat_breed_detector/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Breed Detector',
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
