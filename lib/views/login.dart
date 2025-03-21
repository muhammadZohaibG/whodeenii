import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whodeenii/loginviews/mobileview.dart';
import 'package:whodeenii/loginviews/tabview.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/views/videoscreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  bool rememberMe = false;
  bool isLoading = false;

Future<void> loginfunc() async {
  print("*******************************************************************************");
  setState(() {
    isLoading = true;
  });

  final url = Uri.parse('http://localhost:5241/api/v1/Kiosk/authenticatekiosk');
  final headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'username': emailController.text,
    'password': passwordController.text,
  });

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      // Parse the response
      final responseData = jsonDecode(response.body);
      final successResponse = responseData['successResponse'];

      // Save data to Shared Preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', successResponse['id']);
      await prefs.setString('hotelId', successResponse['hotelId']);
      await prefs.setString('kioskName', successResponse['kioskName']);
      await prefs.setString('token', successResponse['token']);
      await prefs.setString('logo', successResponse['logo']);

      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VideoScreen()),
      );
    } else {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  } catch (e) {
    // Handle network or other errors
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  }
}


  // void loginfunc() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => VideoScreen()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isTablet = width > 900;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(bgimage, fit: BoxFit.cover)),
          Center(
            child: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(loginwhite),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    isTablet
                        ? LoginFormT(
                          emailController: emailController,
                          passwordController: passwordController,
                          rememberMe: rememberMe,
                          onRememberMeChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                          onLoginPressed: loginfunc,
                          isLoading: isLoading,
                        )
                        : LoginFormM(
                          emailController: emailController,
                          passwordController: passwordController,
                          rememberMe: rememberMe,
                          onRememberMeChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                          onLoginPressed: loginfunc,
                        ),
              ),
   

            ),
          ),
        ],
      ),
    );
  }
}
