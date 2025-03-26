import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/urls.dart';
import 'package:whodeenii/views/videoscreen.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    setLoading(true);

    final url = Uri.parse(authurl);
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'username': username, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);
      setLoading(false);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final successResponse = responseData['successResponse'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', successResponse['id']);
        await prefs.setString('hotelId', successResponse['hotelId']);
        await prefs.setString('kioskName', successResponse['kioskName']);
        await prefs.setString('token', successResponse['token']);
        await prefs.setString('logo', successResponse['logo']);

        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Login Successful!",
            text: "You have logged in successfully.",
          ),
        ).then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => VideoScreen()),
          );
        });
      } else {
        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Login Failed",
            text: "Invalid username or password. Please try again.",
          ),
        );
      }
    } catch (e) {
      setLoading(false);
      var dialogKey = GlobalKey<ArtDialogState>();
      ArtSweetAlert.show(
        artDialogKey: dialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          confirmButtonColor: AppColors.gray300,
          confirmButtonText: "",
          customColumns: [
            Text(
              "Error",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 400,
              child: Text(
                "An error occurred: $e",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
              ),
            ),
          ],
          dialogMainAxisSize: MainAxisSize.min,
          dialogAlignment: Alignment.center,
          dialogPadding: EdgeInsets.all(20),
          dialogDecoration: BoxDecoration(
            color: AppColors.gray300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      Future.delayed(Duration(seconds: 3), () {
        dialogKey.currentState?.closeDialog();
      });
    }
  }
}
