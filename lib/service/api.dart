import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as interceptor;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whodeenii/service/navigationservice.dart';
import 'package:whodeenii/utils/urls.dart';
import 'package:whodeenii/views/login.dart';

class Api {
  final String _baseUrl = baseurl;

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
      final response = await interceptor.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<bool> updateProfile(Map<String, dynamic> updatedData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String apiUrl = "$baseurl$uploaddetailurl";

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return false;
    }

    print("Using Token: $token");
    print("API URL: $apiUrl");
    print("Request Body: ${jsonEncode(updatedData)}");

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(updatedData),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["isRequestSuccessful"] == true;
      } else if (response.statusCode == 401) {
        await prefs.setString('remember', 'false');
        NavigationService.pushReplacement(LoginPage());
        return false;
      } else {
        throw Exception(
          "Failed to update profile. Status Code: ${response.statusCode}",
        );
      }
    } catch (error) {
      print("Error updating profile: $error");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> fetchProfileFromApi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final reservationid = prefs.getString('reservationid');
    final String apiUrl = '$baseurl$profiledetailurl';

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return null;
    }
    final Map<String, dynamic> requestBody = {
      "reservationId": reservationid,
      "guestId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    };
    print("Using Token: $token");
    print("URl: $apiUrl");
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["isRequestSuccessful"] == true) {
          return data["successResponse"];
        }
      } else if (response.statusCode == 401) {
        await prefs.setString('remember', 'false');
        NavigationService.pushReplacement(LoginPage());
        return null;
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final reservationid = prefs.getString('reservationid');
    final String apiUrl = '$baseurl$getdocumenturl$reservationid';

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
      } else if (response.statusCode == 401) {
        await prefs.setString('remember', 'false');
        NavigationService.pushReplacement(LoginPage());
        return null;
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
    final String apiUrl = '$baseurl$uploaddocumenturl';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final reservationid = prefs.getString('reservationid');

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return false;
    }
    try {
      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
      request.headers["Authorization"] = "Bearer $token";
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['ReservationNumber'] = reservationid!;

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
      } else if (response.statusCode == 401) {
        await prefs.setString('remember', 'false');
        NavigationService.pushReplacement(LoginPage());
        return false;
      } else {
        print("Failed to upload image. Status Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error uploading document: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> completereservationdetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final reservationid = prefs.getString('reservationid');
    final String apiUrl = '$baseurl$completereservation';

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return null;
    }
    final Map<String, dynamic> requestBody = {"reservationId": reservationid};
    print("Using Token: $token");
    print("URl: $apiUrl");
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["isRequestSuccessful"] == true) {
          return data["successResponse"];
        }
      } else if (response.statusCode == 401) {
        await prefs.setString('remember', 'false');
        NavigationService.pushReplacement(LoginPage());
        return null;
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

  static Future<String?> getTermsAndConditions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final reservationid = prefs.getString('reservationid');
    final String apiUrl = '$baseurl$termsconditionpara';

    if (token == null || reservationid == null) {
      print("Error: No token or reservationId found in SharedPreferences");
      return null;
    }

    final Map<String, dynamic> requestBody = {"reservationId": reservationid};
    print("Using Token: $token");
    print("URL: $apiUrl");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["isRequestSuccessful"] == true) {
          return data["successResponse"];
        }
      } else if (response.statusCode == 401) {
        await prefs.setString('remember', 'false');
        NavigationService.pushReplacement(LoginPage());
        return null;
      } else {
        throw Exception(
          "Failed to load terms and conditions. Status Code: ${response.statusCode}",
        );
      }
    } catch (error) {
      print("Error fetching terms and conditions: $error");
    }

    return null;
  }
}
