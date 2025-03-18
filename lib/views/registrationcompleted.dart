import 'package:whodeenii/completereservation/mobileview.dart';
import 'package:whodeenii/components/headercomponenet.dart';
import 'package:whodeenii/components/mainbuttoncomponent.dart';
import 'package:whodeenii/components/mobHeaderComponent.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:whodeenii/views/selectguest.dart';
import 'package:whodeenii/views/singatureregistration.dart';
import 'package:flutter/material.dart';

class RegistrationCompleted extends StatefulWidget {
  const RegistrationCompleted({super.key});

  @override
  State<RegistrationCompleted> createState() => _RegistrationCompletedState();
}

class _RegistrationCompletedState extends State<RegistrationCompleted> {
  void testsub() {}
  void prevbutton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignatueRegistration()),
    );
  }

  void nextbutton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationCompleted()),
    );
  }

  void updatebutton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectGuest()),
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
                        child: ReservationDone(onPressed: updatebutton),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
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
        ],
      ),
    );
  }
}
