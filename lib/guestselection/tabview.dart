import 'package:emsmeraki/GuestSelection/guestmodal.dart';
import 'package:emsmeraki/utils/colors.dart';
import 'package:emsmeraki/utils/images.dart';
import 'package:emsmeraki/utils/sizeconf.dart';
import 'package:emsmeraki/utils/values.dart';
import 'package:flutter/material.dart';

class GuestSelectionT extends StatefulWidget {
  const GuestSelectionT({super.key});

  @override
  State<GuestSelectionT> createState() => _GuestSelectionTState();
}

class _GuestSelectionTState extends State<GuestSelectionT> {
  int selectedIndex = 0;
  List<Guests> guest = [
    Guests(guestname: 'guestname'),
    Guests(guestname: 'guest name'),
    Guests(guestname: 'guestname'),
    Guests(guestname: 'guestname'),
  ];
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: width * 0.4,
                height: height * 0.5,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Digital Registration",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: width * 0.015,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        regdetails,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: width * 0.013,
                          fontFamily: 'Roboto',
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(user),
                              Text(
                                "Select Guest",
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: width * 0.013,
                                  fontFamily: 'Roboto',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            color: Colors.white,
                            width: width * 0.33,
                            height: height * 0.25,
                            child: ListView.builder(
                              padding: EdgeInsets.all(0.0),
                              itemCount: guest.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: height * 0.005,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.005,
                                      horizontal: width * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedIndex == index
                                              ? AppColors.primaryColor
                                              : Colors.white.withOpacity(0.01),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color:
                                            selectedIndex == index
                                                ? AppColors.primaryColor
                                                : Colors.grey,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          selectedIndex == index
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off,
                                          color:
                                              selectedIndex == index
                                                  ? AppColors.grayColor
                                                  : AppColors.primaryColor,
                                        ),
                                        SizedBox(width: width * 0.013),
                                        Text(
                                          guest[index].guestname,
                                          style: TextStyle(
                                            fontSize: height * 0.013,
                                            color:
                                                selectedIndex == index
                                                    ? AppColors.whiteColor
                                                    : AppColors.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: width * 0.4,
                height: height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Scan QR Code",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: MySize.size18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      scanqr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: MySize.size16,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Image.asset(qrcode),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
