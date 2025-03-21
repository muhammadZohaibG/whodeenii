// import 'package:device_preview/device_preview.dart';
import 'package:whodeenii/views/capturedocuments.dart';
import 'package:whodeenii/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whodeenii/views/selectguest.dart';
import 'package:whodeenii/views/singatureregistration.dart';
import 'package:whodeenii/views/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whodeenii',
      home: const SignatureRegistration(),
    );
  }
}
