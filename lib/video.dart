import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController playerController;
  VoidCallback listener;

  void autoPlay() {
    createVideo();
    playerController.play();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => autoPlay());
    listener = () {
      setState(() {
        if (playerController.value.position ==
            playerController.value.duration) {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(seconds: 1),
                  child: LoginPage()));
        }
      });
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.asset("assets/mtp-web-2.webm")
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AspectRatio(
              aspectRatio: 1080 / 2340,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                        playerController,
                      )
                    : Container()),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(seconds: 1),
                  child: LoginPage()));
        },
        child: Icon(Icons.skip_next),
      ),
    );
  }
}
