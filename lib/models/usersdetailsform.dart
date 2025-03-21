import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class UserDetailsForm extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController countryController;
  final TextEditingController onDialCodeChanged;
  final Function(String?) onGenderChanged;

  const UserDetailsForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileController,
    required this.emailController,
    required this.dobController,
    required this.countryController,
    required this.onDialCodeChanged,
    required this.onGenderChanged,
  });

  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  String? selectedGender;
  String selectedCountryCode = "+27";
  String? selectCountry;
  final TextEditingController countrycontroller = TextEditingController();

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
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    MySize().init(context);
    return Column(
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
                SizedBox(
                  width: width * 0.43,
                  height: height * 0.06,
                  child: Container(
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
                      controller: widget.firstNameController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Enter first name",
                        hintStyle: TextStyle(color: AppColors.gray300),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(user),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.whiteColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.whiteColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                            width: 2,
                          ),
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
                  height: height * 0.06,
                  child: TextFormField(
                    controller: widget.lastNameController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Enter last name",
                      hintStyle: TextStyle(color: AppColors.gray300),
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
                        borderSide: BorderSide(color: Colors.white, width: 2),
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
                  height: height * 0.06,
                  child: TextFormField(
                    onTap: _showCountryPicker,
                    controller: widget.onDialCodeChanged,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Country Code(+)",
                      hintStyle: TextStyle(color: AppColors.gray300),
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
                        borderSide: BorderSide(color: Colors.white, width: 2),
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
                  height: height * 0.06,
                  child: TextFormField(
                    controller: widget.mobileController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "xxx-xxxx-xxx",
                      hintStyle: TextStyle(color: AppColors.gray300),
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
                        borderSide: BorderSide(color: Colors.white, width: 2),
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
                  height: height * 0.06,
                  child: TextFormField(
                    controller: widget.emailController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "email@address.com",
                      hintStyle: TextStyle(color: AppColors.gray300),
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
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ],
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
                  height: height * 0.06,
                  child: TextFormField(
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
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "01-01-2025",
                      hintStyle: TextStyle(color: AppColors.gray300),
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
                        borderSide: BorderSide(color: Colors.white, width: 2),
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
                  height: height * 0.06,
                  child: TextFormField(
                    onTap: _showcountryonly,
                    readOnly: true,
                    controller: widget.countryController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Choose Country",
                      hintStyle: TextStyle(color: AppColors.gray300),
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
                        borderSide: BorderSide(color: Colors.white, width: 2),
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
                  height: height * 0.06,
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
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
                      setState(() {
                        selectedGender = newValue;
                        widget.onGenderChanged(newValue);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "-----",
                      hintStyle: TextStyle(color: AppColors.gray300),
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
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
