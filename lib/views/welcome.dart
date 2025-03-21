import 'package:whodeenii/components/confirmbuttoncomp.dart';
import 'package:whodeenii/components/confirmtextcomponent.dart';
import 'package:whodeenii/components/startcomponent.dart';
import 'package:whodeenii/components/textcomponent.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:whodeenii/views/profiledetail.dart';
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
          Stack(
            children: [
              Positioned.fill(child: Image.asset(bgimage, fit: BoxFit.cover)),
              Padding(
                padding: EdgeInsets.all(width * 0.025),
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(homewhite),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.013),
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
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: height * 0.015,
                                ),
                                child:
                                    isloading
                                        ? Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: width * 0.2,
                                                right: width * 0.2,
                                              ),
                                              child: LinearProgressIndicator(
                                                minHeight: 8,
                                                backgroundColor:
                                                    AppColors.gray300,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                      AppColors.primaryColor,
                                                    ),
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
        ],
      ),
    );
  }
}
