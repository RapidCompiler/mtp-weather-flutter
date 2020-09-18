import 'package:flutter/material.dart';
import 'video.dart';
import 'package:flutter/services.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'MTP Weather',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen('assets/flutter-intro.flr', VideoApp(),
          startAnimation: 'intro', backgroundColor: Color(0xffff9900)),
    );
  }
}
