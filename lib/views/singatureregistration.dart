import 'package:emsmeraki/components/headercomponenet.dart';
import 'package:emsmeraki/components/mainbuttoncomponent.dart';
import 'package:emsmeraki/components/mobHeaderComponent.dart';
import 'package:emsmeraki/utils/colors.dart';
import 'package:emsmeraki/utils/images.dart';
import 'package:emsmeraki/utils/values.dart';
import 'package:emsmeraki/views/capturedocuments.dart';
import 'package:emsmeraki/views/registrationcompleted.dart';
import 'package:flutter/material.dart';

class SignatueRegistration extends StatefulWidget {
  const SignatueRegistration({super.key});

  @override
  State<SignatueRegistration> createState() => _SignatueRegistrationState();
}

class _SignatueRegistrationState extends State<SignatueRegistration> {
  void testsub() {}
  void prevbutton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CaptureDocuments()),
    );
  }

  void nextbutton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationCompleted()),
    );
  }

  void handleSubmit() {}

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isTablet = width > 600;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(bgimage, fit: BoxFit.cover)),
          Padding(
            padding: EdgeInsets.all(width * 0.03),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  isTablet
                      ? HeaderComponent(
                        lineLogo: line3,
                        poweredByLogo: logo,
                        heading: "Sign Registration Card",
                        contentline: signdetails,
                      )
                      : MobHeaderComponent(
                        lineLogo: line3,
                        farimontlogo: farimontlogo,
                        heading: "Sign Registration Card",
                        contentline: signdetails,
                      ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.022),
                        child: Column(
                          children: [
                            Text(
                              "Place your ID doc in the middle of rectangle",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 40,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Capture ID Doc",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 40,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Upload ID Card",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: MainButton(
                      buttonText: 'Previous',
                      onPressed: prevbutton,
                      btnbg: AppColors.textgreyColor,
                      btnfg: AppColors.whiteColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: MainButton(
                      buttonText: 'Next',
                      onPressed: nextbutton,
                      btnbg: AppColors.primaryColor,
                      btnfg: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
