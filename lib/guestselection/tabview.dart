import 'package:whodeenii/GuestSelection/guestmodal.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/values.dart';
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
    Guests(guestname: 'guest name'),
    Guests(guestname: 'Guest Name'),
  ];
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: width * 0.52,
                height: height * 0.65,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.012),
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
                      SizedBox(
                        width: width * 0.37,
                        child: Text(
                          regdetails,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.silver95,
                            fontSize: width * 0.013,
                            fontFamily: 'Roboto',
                            decoration: TextDecoration.none,
                          ),
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
                              SizedBox(width: width * 0.005),
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
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: width * 0.5,
                            height: height * 0.45,
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
                                      vertical: height * 0.013,
                                      horizontal: width * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedIndex == index
                                              ? AppColors.primaryColor
                                              : Colors.white.withOpacity(0.01),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            selectedIndex == index
                                                ? AppColors.primaryColor
                                                : AppColors.blackColor,
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
                                          size: height * 0.02,
                                        ),
                                        SizedBox(width: width * 0.01),
                                        Text(
                                          guest[index].guestname,
                                          style: TextStyle(
                                            fontSize: height * 0.015,
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
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: width * 0.36,
                height: height * 0.65,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.012),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Scan QR Code",

                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: width * 0.015,

                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        scanqr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.silver95,
                          fontSize: width * 0.013,
                          fontFamily: 'Roboto',
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Image.asset(
                        qrcode,
                        width: width * 0.32,
                        height: height * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
