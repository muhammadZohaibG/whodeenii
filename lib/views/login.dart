import 'package:emsmeraki/loginviews/mobileview.dart';
import 'package:emsmeraki/loginviews/tabview.dart';
import 'package:flutter/material.dart';
import 'package:emsmeraki/utils/colors.dart';
import 'package:emsmeraki/utils/images.dart';
import 'package:emsmeraki/utils/values.dart';
import 'package:emsmeraki/views/welcome.dart';

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

  void loginfunc() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeReg()),
    );
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
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(homewhite),
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
