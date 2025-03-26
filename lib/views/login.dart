import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whodeenii/loginviews/mobileview.dart';
import 'package:whodeenii/loginviews/tabview.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/service/api.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/views/videoscreen.dart';

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
      rememberService();
    });
  }

  void rememberService() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getString('remember') ?? 'false';
    final token = prefs.getString('token');

    if (rememberMe == 'true' && token != null) {
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

      if (response != null && response['isRequestSuccessful'] == true) {
        final successResponse = response['successResponse'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', successResponse['id']);
        await prefs.setString('hotelId', successResponse['hotelId']);
        await prefs.setString('kioskName', successResponse['kioskName']);
        await prefs.setString('token', successResponse['token']);
        await prefs.setString('logo', successResponse['logo']);
        await prefs.setString('remember', rememberMe.toString());

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
      isLoading = false;
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
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
