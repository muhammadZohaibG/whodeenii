import 'package:whodeenii/components/headercomponenet.dart';
import 'package:whodeenii/components/mobHeaderComponent.dart';
import 'package:whodeenii/service/navigationservice.dart';
import 'package:whodeenii/signatureregistration/mobileview.dart';
import 'package:whodeenii/signatureregistration/tabletview.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:whodeenii/views/capturedocuments.dart';
import 'package:whodeenii/views/registrationcompleted.dart';
import 'package:flutter/material.dart';

class SignatureRegistration extends StatefulWidget {
  const SignatureRegistration({super.key});

  @override
  State<SignatureRegistration> createState() => _SignatureRegistrationState();
}

class _SignatureRegistrationState extends State<SignatureRegistration> {
  void prevbutton() {
    NavigationService.pushReplacement(CaptureDocuments());
  }

  void nextbutton() {
    NavigationService.pushReplacement(RegistrationCompleted());
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
                    isTablet
                        ? Signview(
                          prevPressed: prevbutton,
                          nextPressed: nextbutton,
                        )
                        : SignviewM(),
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
