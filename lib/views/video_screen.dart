import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:whodeenii/views/welcome.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool isVideoLoading = false;
  bool isConnected = true;
  bool isplay = true;
  InAppWebViewController? webViewController;
  Timer? inactivityTimer;
  Timer? replayTimer;
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  @override
  void initState() {
    super.initState();
    checkInternet();
    listenToInternetChanges();
    startInactivityTimer();
    startReplayTimer();
  }

  void startReplayTimer() {
    replayTimer?.cancel();
    replayTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (isConnected && webViewController != null) {
        webViewController!.evaluateJavascript(
          source: '''
          player.getDuration().then(function(duration) {
            player.setCurrentTime(duration - 0.1).then(function() {
              player.pause().then(function() {
                player.setCurrentTime(0).then(function() {
                  player.play();
                });
              });
            });
          });
        ''',
        );
      }
    });
  }

  Future<void> checkInternet() async {
    var results = await Connectivity().checkConnectivity();
    setState(() {
      isConnected =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);
    });
    print(results);
  }

  void listenToInternetChanges() {
    connectivitySubscription?.cancel();

    connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      bool hasConnection =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (mounted) {
        setState(() {
          isConnected = hasConnection;
        });
      }

      print("Internet Status Changed: $isConnected");
    });

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      print("running");
      var results = await Connectivity().checkConnectivity();
      bool currentlyConnected =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (mounted) {
        setState(() {
          isConnected = currentlyConnected;
        });
      }

      print("Periodic Internet Check: $isConnected");
    });
  }

  void startInactivityTimer() {
    inactivityTimer?.cancel();
    inactivityTimer = Timer(const Duration(seconds: 30), () {
      if (isConnected) {
        webViewController?.reload();
      }
    });
  }

  @override
  void dispose() {
    webViewController?.dispose();
    inactivityTimer?.cancel();
    replayTimer?.cancel();
    connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            if (!isConnected)
              Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text(
                  "No Internet Connection",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              VimeoVideoPlayer(
                videoId: '786241143',
                isAutoPlay: true,
                isMuted: true,
                isLooping: true,
                showControls: false,
                onInAppWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onInAppWebViewLoadStart: (controller, url) {
                  setState(() {
                    isVideoLoading = false;
                  });
                },
                onInAppWebViewLoadStop: (controller, url) {
                  setState(() {
                    isVideoLoading = true;
                  });
                },
              ),
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanDown: (_) {
                  print("User interacted, resetting inactivity timer.");
                  startInactivityTimer();
                },
                onTap: () {
                  print("User tapped, navigating to WelcomeReg.");
                  inactivityTimer?.cancel();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeReg()),
                  );
                },
              ),
            ),
            if (isVideoLoading && isConnected)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
