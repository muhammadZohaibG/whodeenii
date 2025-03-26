import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class LogoHelper {
  static Future<Uint8List?> getLogoBytes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Logo = prefs.getString('logo');

    if (base64Logo != null && base64Logo.isNotEmpty) {
      return base64Decode(base64Logo);
    }
    return null;
  }
}
