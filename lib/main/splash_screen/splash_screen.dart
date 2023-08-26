import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toddily_preschool/auth/screens/sign_in_screen.dart';
import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

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
    Timer(Duration(seconds: 5), () {
      // _chewieController!.pause();
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) =>
              SignInScreen(),
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

  // @override
  // void dispose() {
  //   _videoPlayerController!.dispose();
  //   _chewieController!.dispose();
  //   super.dispose();
  // }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  // Future<void> initializeVideoPlayer() async {
  //   _videoPlayerController = VideoPlayerController.asset(
  //       'assets/videos/toddilyIntro.mp4'); // Replace with your actual video path
  //   await _videoPlayerController!.initialize();
  //   _chewieController = ChewieController(
  //     videoPlayerController: _videoPlayerController!,
  //     autoPlay: true,
  //     looping: false,
  //     allowFullScreen: true,
  //     aspectRatio: 16 / 9,
  //     placeholder: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //     ), // Customize the placeholder while video is loading
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: _videoPlayerController!.value.isInitialized
            ?
            // Container(
            //   color: Theme.of(context).colorScheme.secondary,
            //   // margin: EdgeInsets.all(20.sp),
            //     width: double.infinity,
            //     height: double.infinity,
            //     child: VideoPlayer(_videoPlayerController!),
            //   )
            AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
