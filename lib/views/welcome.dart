import 'package:emsmeraki/components/confirmbuttoncomp.dart';
import 'package:emsmeraki/components/confirmtextcomponent.dart';
import 'package:emsmeraki/components/startcomponent.dart';
import 'package:emsmeraki/components/textcomponent.dart';
import 'package:emsmeraki/utils/colors.dart';
import 'package:emsmeraki/utils/images.dart';
import 'package:emsmeraki/utils/values.dart';
import 'package:emsmeraki/views/profileDetail.dart';
import 'package:flutter/material.dart';

class WelcomeReg extends StatefulWidget {
  const WelcomeReg({super.key});

  @override
  State<WelcomeReg> createState() => _WelcomeRegState();
}

class _WelcomeRegState extends State<WelcomeReg> {
  bool isloading = false;
  void onConfirmedPressed() {
    setState(() {
      isloading = true;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isloading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileDetail()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
                image: DecorationImage(
                  image: AssetImage(homewhite),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: HeaderWidget(
                        fairmontLogo: farimontlogo,
                        poweredByLogo: logo,
                      ),
                    ),
                    WelcomeTextWidget(
                      title: startline,
                      description: startdiscription,
                      width: width,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          isloading
                              ? Text.rich(
                                TextSpan(text: "Loading..."),
                                textAlign: TextAlign.center,
                              )
                              : ConfirmTextWidget(width: width),
                          SizedBox(height: height * 0.02),
                          isloading
                              ? Column(
                                children: [
                                  LinearProgressIndicator(
                                    minHeight: 8,
                                    backgroundColor: AppColors.gray300,
                                    valueColor: AlwaysStoppedAnimation(
                                      AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                ],
                              )
                              : ConfirmButton(
                                onPressed: onConfirmedPressed,
                                width: width,
                                height: height,
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
