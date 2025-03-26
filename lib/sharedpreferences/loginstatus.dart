import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _isLoggedInKey = "isloggedin";
  static Future<void> setLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, status);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }
}
