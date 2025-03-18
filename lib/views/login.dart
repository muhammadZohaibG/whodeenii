import 'package:whodeenii/loginviews/mobileview.dart';
import 'package:whodeenii/loginviews/tabview.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/views/welcome.dart';

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
