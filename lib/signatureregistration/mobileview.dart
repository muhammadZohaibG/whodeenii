import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';

class SignviewM extends StatefulWidget {
  const SignviewM({super.key});

  @override
  _SignviewMState createState() => _SignviewMState();
}

class _SignviewMState extends State<SignviewM> {
  String? selectedGender;
  String selectedCountryCode = "+27";
  String? selectCountry;
  final TextEditingController countrycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    MySize().init(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.022),
          child: Column(
            children: [
              Text(
                "Place your ID doc in the middle of rectangle",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 40, color: Colors.black54),
                      SizedBox(height: 10),
                      Text(
                        "Capture ID Doc",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
