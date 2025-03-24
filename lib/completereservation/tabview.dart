import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:flutter/material.dart';

class ReservationDoneT extends StatefulWidget {
  final VoidCallback onPressed;
  const ReservationDoneT({super.key, required this.onPressed});

  @override
  State<ReservationDoneT> createState() => _ReservationDoneTState();
}

class _ReservationDoneTState extends State<ReservationDoneT> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * 0.63,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reservation No. 74632",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: width * 0.017,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.46,
                height: height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date of Arrival",
                      style: TextStyle(
                        color: AppColors.gray4959,
                        fontSize: width * 0.013,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "08-04-2025",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.017,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "Adults",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.013,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "08",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.017,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "Room Type",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.013,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "Standard Room with Balcony",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.017,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.3,
                width: width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date of Departure",
                      style: TextStyle(
                        color: AppColors.gray4959,
                        fontSize: width * 0.013,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "08-04-2025",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.017,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "Children",
                      style: TextStyle(
                        color: AppColors.gray4959,
                        fontSize: width * 0.013,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "01",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.017,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "Room Number",
                      style: TextStyle(
                        color: AppColors.gray4959,
                        fontSize: width * 0.013,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "34",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: width * 0.017,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.01),

          SizedBox(height: height * 0.02),

          Text(
            "Update Details",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: width * 0.017,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "You can update your details if you want to by clicking the button below.",
            style: TextStyle(
              color: AppColors.gray4959,
              fontSize: width * 0.012,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Container(
            width: width,
            height: height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.025,
                right: width * 0.025,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Primary Guest Name",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: width * 0.015,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      decoration: TextDecoration.none,
                    ),
                  ),
                  CustomButton(
                    buttonText: "Update Details",
                    onPressed: widget.onPressed,
                    btnbg: AppColors.blackColor,
                    btnfg: AppColors.whiteColor,
                    height: height * 0.055,
                    width: width * 0.17,
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
