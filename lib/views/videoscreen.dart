import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:whodeenii/service/navigationservice.dart';
import 'package:whodeenii/service/signalrservice.dart';
import 'package:whodeenii/utils/urls.dart';
import 'package:whodeenii/views/welcome.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final SignalRService _signalRService = SignalRService();
  bool isVideoLoading = false;
  bool isConnected = true;
  bool isplay = true;
  InAppWebViewController? webViewController;
  Timer? inactivityTimer;
  Timer? replayTimer;
  String receivedMessage = "Waiting for messages...";

  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  @override
  void initState() {
    super.initState();
    checkInternet();
    listenToInternetChanges();
    startInactivityTimer();
    startReplayTimer();
    _initSignalR();
  }

  void _initSignalR() {
    // Replace with your SignalR hub URL
    final connectionUrl = 'https://localhost:44326/notificationhub';

    // Create the HubConnection
    _hubConnection = HubConnectionBuilder().withUrl(connectionUrl).build();

    // Listen for messages from the server
    _hubConnection.on('ReceiveMessage', _handleMessage);

    // Start the connection
    _hubConnection.start()?.catchError((error) {
      print('SignalR connection error: $error');
    });
  }

  void _handleMessage(List<dynamic>? arguments) {
    if (arguments != null && arguments.isNotEmpty) {
      setState(() {
        receivedMessage = arguments.first.toString();
      });
    }
  }

  void startReplayTimer() {
    replayTimer?.cancel();
    replayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (isConnected && webViewController != null) {
        webViewController!.evaluateJavascript(
          source: '''
        player.getPaused().then(function(isPaused) {
          if (isPaused) {
            player.play();
          }
        }).catch(function(error) {
          console.log("Error checking video state:", error);
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
    });

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      var results = await Connectivity().checkConnectivity();
      bool currentlyConnected =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (mounted) {
        setState(() {
          isConnected = currentlyConnected;
        });
      }
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeReg()),
                  );
                },
                behavior: HitTestBehavior.translucent,

                child: IgnorePointer(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: VimeoVideoPlayer(
                      videoId: videoId,
                      isAutoPlay: true,
                      isMuted: true,
                      isLooping: true,
                      showControls: false,
                      onInAppWebViewCreated: (controller) {
                        webViewController = controller;
                        controller.setOptions(
                          options: InAppWebViewGroupOptions(
                            android: AndroidInAppWebViewOptions(
                              mixedContentMode:
                                  AndroidMixedContentMode
                                      .MIXED_CONTENT_ALWAYS_ALLOW,
                            ),
                          ),
                        );
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
                  ),
                ),
              ),
            if (isVideoLoading && !isConnected)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
