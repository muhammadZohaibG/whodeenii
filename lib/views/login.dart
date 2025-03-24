import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whodeenii/loginviews/mobileview.dart';
import 'package:whodeenii/loginviews/tabview.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/service/api.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/views/videoscreen.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  bool rememberMe = false;
  bool isLoading = false;
    @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rememberService(); // Ensures it runs after the widget builds
    });
  }

void rememberService() async {

  final prefs = await SharedPreferences.getInstance();
  final rememberMe = prefs.getString('remember') ?? 'false'; // Default to 'false'
  final token = prefs.getString('token');


  if (rememberMe == 'true' && token != null) {
    // Navigate to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => VideoScreen()),
    );
  }
}


  Future<void> loginfunc() async {

   
    setState(() {
      isLoading = true;
    });

    final apiService = Api();
    try {
      final response = await apiService.login(
        usernameController.text,
        passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (response != null && response['isRequestSuccessful']==true) {
        final successResponse = response['successResponse'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', successResponse['id']);
        await prefs.setString('hotelId', successResponse['hotelId']);
        await prefs.setString('kioskName', successResponse['kioskName']);
        await prefs.setString('token', successResponse['token']);
        await prefs.setString('logo', successResponse['logo']);
        await prefs.setString('remember', rememberMe.toString());

        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VideoScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }




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
                          usernameController: usernameController,
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
                          usernameController: usernameController,
                          passwordController: passwordController,
                          rememberMe: rememberMe,
                          onRememberMeChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                          onLoginPressed: loginfunc,
                          isLoading: isLoading,

                        ),
              ),
   

            ),
          ),
        ],
      ),
    );
  }
}
