import 'package:emsmeraki/completereservation/mobileview.dart';
import 'package:emsmeraki/components/headercomponenet.dart';
import 'package:emsmeraki/components/mainbuttoncomponent.dart';
import 'package:emsmeraki/components/mobHeaderComponent.dart';
import 'package:emsmeraki/components/startcomponent.dart';
import 'package:emsmeraki/guestselection/mobileview.dart';
import 'package:emsmeraki/guestselection/tabview.dart';
import 'package:emsmeraki/utils/colors.dart';
import 'package:emsmeraki/utils/images.dart';
import 'package:emsmeraki/utils/values.dart';
import 'package:emsmeraki/views/registrationcompleted.dart';
import 'package:emsmeraki/views/singatureregistration.dart';
import 'package:flutter/material.dart';

class SelectGuest extends StatefulWidget {
  const SelectGuest({super.key});

  @override
  State<SelectGuest> createState() => _SelectGuestState();
}

class _SelectGuestState extends State<SelectGuest> {
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
      MaterialPageRoute(builder: (context) => SelectGuest()),
    );
  }

  void proceedfunc() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationCompleted()),
    );
  }

  void updatebutton() {}

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
                  HeaderWidget(fairmontLogo: farimontlogo, poweredByLogo: logo),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.022),
                        child: isTablet ? GuestSelectionT() : GuestSelection(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: MainButton(
                      buttonText: 'Proceed',
                      onPressed: proceedfunc,
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
