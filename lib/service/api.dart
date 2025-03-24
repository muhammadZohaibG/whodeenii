import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' as _interceptor;

class Api {
  static const String _baseUrl = 'http://localhost:5241/api/v1';

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/Kiosk/authenticatekiosk');
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null; // Login failed
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

    /// Makes a GET request using the interceptor
  Future<Map<String, dynamic>?> getData(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');

    try {
      final response = await _interceptor.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}