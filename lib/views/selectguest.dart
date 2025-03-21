import 'package:whodeenii/components/mainbuttoncomponent.dart';
import 'package:whodeenii/components/startcomponent.dart';
import 'package:whodeenii/guestselection/mobileview.dart';
import 'package:whodeenii/guestselection/tabview.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/views/registrationcompleted.dart';
import 'package:whodeenii/views/singatureregistration.dart';
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
      MaterialPageRoute(builder: (context) => SignatureRegistration()),
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
                image: DecorationImage(
                  image: AssetImage(homewhite),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.02,
                      right: width * 0.01,
                      left: width * 0.01,
                      bottom: height * 0.02,
                    ),
                    child: SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: HeaderWidget(
                        fairmontLogo: farimontlogo,
                        poweredByLogo: logo,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: isTablet ? GuestSelectionT() : GuestSelection(),
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
