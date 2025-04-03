import 'package:shared_preferences/shared_preferences.dart';
import 'package:whodeenii/completereservation/mobileview.dart';
import 'package:whodeenii/completereservation/tabview.dart';
import 'package:whodeenii/components/headercomponenet.dart';
import 'package:whodeenii/components/mainbuttoncomponent.dart';
import 'package:whodeenii/components/mobHeaderComponent.dart';
import 'package:whodeenii/service/navigationservice.dart';
import 'package:whodeenii/service/signalrservice.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:whodeenii/views/profiledetail.dart';
import 'package:whodeenii/views/singatureregistration.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/views/videoscreen.dart';

class RegistrationCompleted extends StatefulWidget {
  const RegistrationCompleted({super.key});

  @override
  State<RegistrationCompleted> createState() => _RegistrationCompletedState();
}

class _RegistrationCompletedState extends State<RegistrationCompleted> {
  final SignalRService _signalRService = SignalRService();
  void prevbutton() {
    NavigationService.pushReplacement(SignatureRegistration());
  }

  void updatebutton() {
    NavigationService.pushReplacement(ProfileDetail());
  }

  void handleSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString('userid');
    final Map<String, dynamic> sendResponse = {
      "Identifier": userid,
      "Status": "Completed",
    };
    await _signalRService.invokeMethod("ReturnAcknowledgement", sendResponse);
    NavigationService.pushReplacement(VideoScreen());
  }

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
                image: DecorationImage(
                  image: AssetImage(homewhite),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Column(
                  children: [
                    isTablet
                        ? HeaderComponent(
                          lineLogo: line4,
                          poweredByLogo: logo,
                          heading: "Digital Registration Completed",
                          contentline: congrats,
                        )
                        : MobHeaderComponent(
                          lineLogo: line4,
                          farimontlogo: farimontlogo,
                          heading: "Digital Registration Completed",
                          contentline: congrats,
                        ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.022),
                          child:
                              isTablet
                                  ? ReservationDoneT(onPressed: updatebutton)
                                  : ReservationDone(onPressed: updatebutton),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.006,
                        right: width * 0.006,
                      ),
                      child: MainButton(
                        buttonText: 'Complete Reservation',
                        onPressed: handleSubmit,
                        btnbg: AppColors.primaryColor,
                        btnfg: AppColors.whiteColor,
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
