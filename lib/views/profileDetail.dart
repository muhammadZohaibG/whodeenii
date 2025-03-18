// import 'package:whodeenii/views/mobileview.dart';
// import 'package:whodeenii/views/tabletview.dart';
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  String? selectedDialCode;
  String? selectedGender;

  void handleSubmit() {
    print("First Name: ${firstNameController.text}");
    print("Last Name: ${lastNameController.text}");
    print("Mobile Number: ${mobileController.text}");
    print("Email Address: ${emailController.text}");
    print("Date of Birth: ${dobController.text}");
    print("Dialing Code: $selectedDialCode");
    print("Date of Birth: ${countryController.text}");
    print("Gender: $selectedGender");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CaptureDocuments()),
    );
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
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: EdgeInsets.all(width * 0.022),
                        child:
                            isTablet
                                ? UserDetailsForm(
                                  firstNameController: firstNameController,
                                  lastNameController: lastNameController,
                                  mobileController: mobileController,
                                  emailController: emailController,
                                  dobController: dobController,
                                  onDialCodeChanged:
                                      (value) => setState(
                                        () => selectedDialCode = value,
                                      ),
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
                                  onDialCodeChanged:
                                      (value) => setState(
                                        () => selectedDialCode = value,
                                      ),
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
        ],
      ),
    );
  }
}
