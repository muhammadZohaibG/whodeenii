import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:whodeenii/views/welcome.dart';
import 'package:signalr_netcore/signalr_client.dart';

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
  String receivedMessage = "Waiting for messages...";
  late HubConnection _hubConnection;

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

  void _initSignalR() async {
    final connectionUrl = 'http://www.whodenisignalr.local/notificationhub';

    _hubConnection = HubConnectionBuilder().withUrl(connectionUrl).build();

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');

    final signalRMethodName = 'HubQueue$id';

    _hubConnection.on(signalRMethodName, _handleMessage);

    _hubConnection.start()?.catchError((error) {
      print('SignalR connection error: $error');
    });
  }

  void _handleMessage(List<dynamic>? arguments) {
    print(arguments);

    if (arguments != null && arguments.isNotEmpty) {
      final payload = arguments.first;

      if (payload is Map<String, dynamic>) {
        final getProfile = payload['getProfile'] == true;

        if (getProfile) {
          _fetchProfileData(); // 👈 your custom function
        }

        // Optional: update UI with the full message
        setState(() {
          receivedMessage = payload.toString();
        });
      } else {
        print("Payload is not a valid map.");
      }
    }
  }

  void _fetchProfileData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeReg()),
    );
    // Add your logic to fetch profile, call API, update state, etc.
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
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  print("asdjknakndkd");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeReg()),
                  );
                },
                child: IgnorePointer(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: VimeoVideoPlayer(
                      videoId: '475418823',
                      isAutoPlay: true,
                      isMuted: true,
                      isLooping: true,
                      showControls: false,
                      onInAppWebViewCreated: (controller) {
                        webViewController = controller;

                        webViewController!.addJavaScriptHandler(
                          handlerName: 'videoState',
                          callback: (args) {
                            if (args.isNotEmpty && args[0] == 'playing') {
                              setState(() {
                                isVideoLoading = false;
                              });
                            }
                          },
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
