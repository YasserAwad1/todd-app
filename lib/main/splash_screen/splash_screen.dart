import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/auth/screens/sign_in_screen.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/main/about/screens/about_screen.dart';
import 'package:toddily_preschool/main/classes/screens/classes_screen.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _videoPlayerController;
  // ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // initializeVideoPlayer();

    _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/toddilyIntro.mp4'); // Replace with your actual video path
    _videoPlayerController!.initialize().then((_) {
      setState(() {});
      _videoPlayerController!.setLooping(false);
      _videoPlayerController!.play();
    });
    Timer(const Duration(seconds: 6), () async {
      bool isTokenValid =
          await Provider.of<AuthProvider>(context, listen: false)
              .isTokenValid();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) {
            if (locator.get<LocalRepo>().role == 'guest') {
              return AboutScreen();
            }
            if (isTokenValid) {
              if (Provider.of<AuthProvider>(context, listen: false)
                  .classesTile()) {
                return ClassesScreen();
              } else {
                return KidsScreen();
              }
            } else {
              return SignInScreen();
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: _videoPlayerController!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              )
            : Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              )),
      ),
    );
  }
}
