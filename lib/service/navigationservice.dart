import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void pushReplacement(Widget screen) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
