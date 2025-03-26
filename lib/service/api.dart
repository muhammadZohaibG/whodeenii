import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as _interceptor;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whodeenii/utils/urls.dart';

class Api {
  static const String _baseUrl = baseurl;

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/Kiosk/authenticatekiosk');
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'username': username, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);

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

  static Future<Map<String, dynamic>?> fetchProfileFromApi() async {
    const String apiUrl = profiledetailurl;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return null;
    }

    print("Using Token: $token");

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["isRequestSuccessful"] == true) {
          return data["successResponse"];
        }
      } else {
        throw Exception(
          "Failed to load profile data. Status Code: ${response.statusCode}",
        );
      }
    } catch (error) {
      print("Error fetching profile: $error");
    }

    return null;
  }

  static Future<Map<String, dynamic>?> fetchdocumentfromapi() async {
    const String apiUrl = getdocumenturl;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["isRequestSuccessful"] == true) {
          return data["successResponse"];
        }
      } else {
        throw Exception(
          "Failed to load profile data. Status Code: ${response.statusCode}",
        );
      }
    } catch (error) {
      print("Error fetching profile: $error");
    }

    return null;
  }

  static Future<bool> uploadDocumentImage(File imageFile) async {
    const String apiUrl = uploaddocumenturl;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return false;
    }
    try {
      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
      request.headers["Authorization"] = "Bearer $token";
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['ReservationNumber'] = '666666';

      var fileStream = await http.MultipartFile.fromPath(
        'IdDocument',
        imageFile.path,
        filename: basename(imageFile.path),
      );
      request.files.add(fileStream);
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Image uploaded successfully!");
        return true;
      } else {
        print("Failed to upload image. Status Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error uploading document: $e");
      return false;
    }
  }
}
