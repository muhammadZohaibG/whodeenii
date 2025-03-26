import 'package:whodeenii/components/headercomponenet.dart';
import 'package:whodeenii/components/mainbuttoncomponent.dart';
import 'package:whodeenii/components/mobHeaderComponent.dart';
import 'package:whodeenii/models/usersdetailsform.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/models/mobileview.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:whodeenii/views/capturedocuments.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dialcodeController = TextEditingController();

  String? selectedGender;

  void handleSubmit() {
    if (profileFormKey.currentState!.validate()) {
      print("First Name: ${firstNameController.text}");
      print("Last Name: ${lastNameController.text}");
      print("Mobile Number: ${mobileController.text}");
      print("Email Address: ${emailController.text}");
      print("Date of Birth: ${dobController.text}");
      print("Dialing Code: ${dialcodeController.text}");
      print("Country Name: ${countryController.text}");
      print("Gender: $selectedGender");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CaptureDocuments()),
      );
    }
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
                padding: EdgeInsets.all(width * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isTablet
                        ? HeaderComponent(
                          lineLogo: logoline,
                          poweredByLogo: logo,
                          heading: "Profile Details",
                          contentline: filldetails,
                        )
                        : MobHeaderComponent(
                          lineLogo: logoline,
                          farimontlogo: farimontlogo,
                          heading: "Profile Details",
                          contentline: filldetails,
                        ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.02,
                            bottom: width * 0.02,
                            top: width * 0.01,
                            right: width * 0.02,
                          ),
                          child:
                              isTablet
                                  ? UserDetailsForm(
                                    formKey: profileFormKey,
                                    firstNameController: firstNameController,
                                    lastNameController: lastNameController,
                                    mobileController: mobileController,
                                    emailController: emailController,
                                    dobController: dobController,
                                    onDialCodeChanged: dialcodeController,
                                    countryController: countryController,
                                    onGenderChanged:
                                        (value) => setState(
                                          () => selectedGender = value,
                                        ),
                                  )
                                  : MobileView(
                                    firstNameController: firstNameController,
                                    lastNameController: lastNameController,
                                    mobileController: mobileController,
                                    emailController: emailController,
                                    dobController: dobController,
                                    onDialCodeChanged: dialcodeController,
                                    countryController: countryController,
                                    onGenderChanged:
                                        (value) => setState(
                                          () => selectedGender = value,
                                        ),
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
                        buttonText: 'Next',
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
