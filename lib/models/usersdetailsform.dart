import 'package:shared_preferences/shared_preferences.dart';
import 'package:whodeenii/service/api.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class UserDetailsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController countryController;
  final TextEditingController countryCodeController;
  final TextEditingController onDialCodeChanged;
  final TextEditingController genderController;

  const UserDetailsForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileController,
    required this.emailController,
    required this.dobController,
    required this.countryController,
    required this.countryCodeController,
    required this.onDialCodeChanged,
    required this.genderController,
  });

  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    setState(() => isLoading = true);

    final profile = await Api.fetchProfileFromApi();
    if (profile != null) {
      if (profile["mobileNo"] != null) {
        widget.mobileController.text = profile["mobileNo"];
      }
      if (profile["dialingCode"] != null) {
        widget.onDialCodeChanged.text = profile["dialingCode"];
      }
      if (profile["country"] != null) {
        widget.countryController.text = profile["country"];
      }

      if (profile["firstName"] != null) {
        widget.firstNameController.text = profile["firstName"].trim();
      }
      if (profile["lastName"] != null) {
        widget.lastNameController.text = profile["lastName"].trim();
      }

      widget.emailController.text = profile["email"];
      if (profile["dateOfBirth"] != null) {
        widget.dobController.text = profile["dateOfBirth"].split("T")[0];
      }

      widget.genderController.text =
          ["Male", "Female", "Other"].contains(profile["gender"])
              ? profile["gender"]
              : "";

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      if (profile["reservationId"] != null && profile["guestId"] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('guestid', profile["guestId"]);
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  String? selectedGender;
  String selectedCountryCode = "+27";
  String? selectCountry;
  final TextEditingController countrycontroller = TextEditingController();
  late double heightf = 0.06;
  late double heightl = 0.06;
  late double heightd = 0.06;
  late double heightm = 0.06;
  late double heighte = 0.06;
  late double heightb = 0.06;
  late double heightc = 0.06;
  late double heightg = 0.06;

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedCountryCode = "+${country.phoneCode}";
          widget.onDialCodeChanged.text = selectedCountryCode;
        });
      },
    );
  }

  void _showcountryonly() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          // selectedCountryCode = "+${country.phoneCode}";
          widget.countryController.text = country.displayNameNoCountryCode;
          widget.countryCodeController.text = country.countryCode;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    MySize().init(context);
    setState(() {});
    return isLoading
        ? CircularProgressIndicator()
        : Form(
          key: widget.formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "First Name",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.43,
                        height: height * heightf,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heightf = 0.08;
                              });
                              return 'Enter Your First Name';
                            } else {
                              heightf = 0.06;
                              return null;
                            }
                          },
                          controller: widget.firstNameController,
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Enter first name",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(user),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Last Name",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        height: height * heightl,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heightl = 0.08;
                              });
                              return 'Enter Your Last Name';
                            } else {
                              heightl = 0.06;
                              return null;
                            }
                          },
                          controller: widget.lastNameController,
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Enter last name",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(user),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.025),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Dialing Codes",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        height: height * heightd,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heightd = 0.08;
                              });
                              return 'Select Your Dialing Code';
                            } else {
                              heightd = 0.06;
                              return null;
                            }
                          },
                          onTap: _showCountryPicker,
                          controller: widget.onDialCodeChanged,
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Country Code(+)",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(code),
                            ),
                            suffixIcon: IconButton(
                              onPressed: _showCountryPicker,
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Mobile Number",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        height: height * heightm,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heightm = 0.08;
                              });
                              return 'Enter Your Mobile Number';
                            } else {
                              heightm = 0.06;
                              return null;
                            }
                          },
                          controller: widget.mobileController,
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "xxx-xxxx-xxx",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(telephone),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.025),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Email Address",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    fontSize: MySize.size16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        height: height * heighte,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heighte = 0.08;
                              });
                              return 'Enter Your Email';
                            } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            ).hasMatch(value)) {
                              setState(() {
                                heighte = 0.08;
                              });
                              return 'Enter a valid email address';
                            } else {
                              heighte = 0.06;
                              return null;
                            }
                          },
                          controller: widget.emailController,
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "email@address.com",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(email),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ],
              ),
              SizedBox(height: height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MySize.size35,
                    child: Text(
                      "More Details...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.014,
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text(
                            "Date of Birth (mm/dd/yyyy)",
                            style: TextStyle(
                              fontSize: MySize.size16,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        height: height * heightb,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heightb = 0.08;
                              });
                              return 'Select Your Date Of Birth';
                            } else {
                              heightb = 0.06;
                              return null;
                            }
                          },
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                widget.dobController.text =
                                    "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                              });
                            }
                          },
                          controller: widget.dobController,
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "01-01-2025",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            prefixIcon: GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    widget.dobController.text =
                                        "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Image.asset(calendar),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text(
                            "Country",
                            style: TextStyle(
                              fontSize: MySize.size16,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        height: height * heightc,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heightc = 0.08;
                              });
                              return 'Select Your Country';
                            } else {
                              heightc = 0.06;
                              return null;
                            }
                          },
                          onTap: _showcountryonly,
                          readOnly: true,
                          controller: widget.countryController,
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Choose Country",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            suffixIcon: IconButton(
                              onPressed: _showcountryonly,
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(circle),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: SizedBox(
                          height: MySize.size25,
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: MySize.size16,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        height: height * heightg,
                        child: DropdownButtonFormField<String>(
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.2,
                          ),
                          value:
                              widget.genderController.text.isNotEmpty
                                  ? widget.genderController.text
                                  : null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                heightg = 0.08;
                              });
                              return 'Select Gender';
                            } else {
                              heightg = 0.06;
                              return null;
                            }
                          },
                          items:
                              ["Male", "Female", "Other"]
                                  .map(
                                    (String value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                widget.genderController.text = newValue;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "-----",
                            hintStyle: TextStyle(color: AppColors.gray300),
                            errorStyle: TextStyle(height: 0),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(gender),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 204, 203, 203),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 204, 203, 203),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 204, 203, 203),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
  }
}
