import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/main/auth/screens/sign_in_screen.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/main/about/screens/about_screen.dart';
import 'package:toddily_preschool/main/classes/screens/classes_screen.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:toddily_preschool/main/splash_screen/providers/splash_provider.dart';
import 'package:toddily_preschool/main/splash_screen/widgets/no_internet_dialog.dart';
import 'package:video_player/video_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late ConnectivityResult result;

  Future<void> initConnectivity() async {
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  VideoPlayerController? _videoPlayerController;
  var _userFuture;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/toddilyIntro.mp4');
    _videoPlayerController!.initialize().then((_) {
      setState(() {});
      _videoPlayerController!.setLooping(false);
      _videoPlayerController!.play();
    });
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    Timer(const Duration(seconds: 6), () async {
      if (result == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return NoInternetDialog(
                tryAgain: 0,
              );
            });
      } else {
        bool isTokenValid =
            await Provider.of<AuthProvider>(context, listen: false)
                .isTokenValid();

        if (isTokenValid) {
          // ignore: use_build_context_synchronously
          _userFuture = await Provider.of<UserProvider>(context, listen: false)
              .getCurrentUser();
          // print(Provider.of<UserProvider>(context, listen: false).currentUser);
          // print('****************GETTING CURRENT USER*******************');
        }
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
                return FutureBuilder(
                  future: _userFuture,
                  builder: (context, snapshot) {
                    bool isNotification =
                        Provider.of<SplashProvider>(context, listen: false)
                            .isNotification;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Platform.isIOS
                          ? CupertinoActivityIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            )
                          : CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            );
                    }
                    if (isNotification) {
                      Navigator.pushReplacementNamed(
                          context, KidsScreen.routeName);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Provider.of<SplashProvider>(context,
                                listen: false)
                            .handleNotification();
                      }));
                      return Container();
                    } else {
                      if (Provider.of<UserProvider>(context, listen: false)
                          .classesTile()) {
                        return ClassesScreen();
                      } else {
                        return KidsScreen();
                      }
                    }
                  },
                );
              } else {
                return SignInScreen();
              }
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _connectivitySubscription.cancel();
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
