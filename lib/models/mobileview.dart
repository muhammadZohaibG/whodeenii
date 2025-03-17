import 'package:emsmeraki/utils/images.dart';
import 'package:emsmeraki/utils/sizeconf.dart';
import 'package:flutter/material.dart';
import 'package:show_country_picker_flutter/show_country_picker_flutter.dart';

class MobileView extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController countryController;
  final Function(String?) onDialCodeChanged;
  final Function(String?) onGenderChanged;
  const MobileView({
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
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  String? selectedDialCode;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    MySize().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text(
                "First Name*",
                style: TextStyle(fontSize: MySize.size14),
              ),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
              child: TextField(
                controller: widget.firstNameController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Enter first name",
                  prefixIcon: Image.asset(user),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text(
                "Last Name*",
                style: TextStyle(fontSize: MySize.size14),
              ),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
              child: TextField(
                controller: widget.lastNameController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Enter Last name",
                  prefixIcon: Image.asset(user),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text(
                "Dialing Codes*",
                style: TextStyle(fontSize: MySize.size14),
              ),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
              child: TextField(
                controller: widget.firstNameController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Country code (+)",
                  prefixIcon: Image.asset(code),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text(
                "Mobile Number*",
                style: TextStyle(fontSize: MySize.size14),
              ),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
              child: TextField(
                controller: widget.mobileController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "xxx-xxxx-xxx",
                  prefixIcon: Image.asset(telephone),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text(
                "Email Address*",
                style: TextStyle(fontSize: MySize.size14),
              ),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
              child: TextField(
                controller: widget.emailController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "email@address.com",
                  prefixIcon: Image.asset(email),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text(
                "More Details...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MySize.size15,
                ),
              ),
            ),
            SizedBox(width: width),
          ],
        ),
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text(
                "Date of Birth (mm/dd/yyyy)",
                style: TextStyle(fontSize: MySize.size14),
              ),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
              child: TextField(
                controller: widget.dobController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.none,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "00-00-0000",
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
                      child: Image.asset(
                        calendar,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text("Country", style: TextStyle(fontSize: MySize.size14)),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
              child: TextField(
                controller: widget.countryController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.none,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Choose Country",
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      ShowCountryPickerFlutter(
                        textEditingController: widget.countryController,
                        focusNode: FocusNode(),
                        onTap: (Map<String, dynamic> countryDetail) {
                          setState(() {
                            widget.countryController.text =
                                countryDetail["name"] ?? "";
                          });
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        circle,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size25,
              child: Text("Gender*", style: TextStyle(fontSize: MySize.size14)),
            ),
            SizedBox(
              width: width,
              height: MySize.size35,
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
                  hintText: "----",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      gender,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
