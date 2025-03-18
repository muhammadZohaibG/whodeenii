import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/components/headercomponenet.dart';
import 'package:whodeenii/components/mainbuttoncomponent.dart';
import 'package:whodeenii/components/mobHeaderComponent.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:whodeenii/views/profileDetail.dart';
import 'package:whodeenii/views/singatureregistration.dart';
import 'package:flutter/material.dart';

class CaptureDocuments extends StatefulWidget {
  const CaptureDocuments({super.key});

  @override
  State<CaptureDocuments> createState() => _CaptureDocumentsState();
}

class _CaptureDocumentsState extends State<CaptureDocuments> {
  void testsub() {}
  void prevbutton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileDetail()),
    );
  }

  void nextbutton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignatueRegistration()),
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
                        lineLogo: line2,
                        poweredByLogo: logo,
                        heading: "Upload or Capture ID Document",
                        contentline: uploaddetails,
                      )
                      : MobHeaderComponent(
                        lineLogo: line2,
                        farimontlogo: farimontlogo,
                        heading: "Upload or Capture ID Document",
                        contentline: uploaddetails,
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
                      buttonText: 'Keep Existing',
                      onPressed: testsub,
                      btnbg: AppColors.blackColor,
                      btnfg: AppColors.whiteColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        buttonText: 'Previous',
                        onPressed: prevbutton,
                        btnbg: AppColors.textgreyColor,
                        btnfg: AppColors.whiteColor,
                        height: height,
                        width: width * 0.33,
                      ),
                      SizedBox(width: width * 0.02),
                      CustomButton(
                        buttonText: 'Next',
                        onPressed: nextbutton,
                        btnbg: AppColors.primaryColor,
                        btnfg: AppColors.whiteColor,
                        height: height,
                        width: width * 0.33,
                      ),
                    ],
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
