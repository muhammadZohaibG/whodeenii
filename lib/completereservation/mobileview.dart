import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';

class ReservationDone extends StatefulWidget {
  final VoidCallback onPressed;
  const ReservationDone({super.key, required this.onPressed});

  @override
  State<ReservationDone> createState() => _ReservationDoneState();
}

class _ReservationDoneState extends State<ReservationDone> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reservation No. 74632",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: MySize.size18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Date of Arrival",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "08-04-2025",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Date of Departure",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "08-04-2025",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
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
              fontSize: MySize.size16,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "08",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Children",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "01",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
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
              fontSize: MySize.size16,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "Standard Room with Balcony",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Room Number",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "34",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: height * 0.02),

          Text(
            "Update Details",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "You can Update any of the guest details",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Container(
            width: width,
            height: height * 0.17,
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
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      decoration: TextDecoration.none,
                    ),
                  ),
                  CustomButton(
                    buttonText: "Update Now",
                    onPressed: widget.onPressed,
                    btnbg: AppColors.blackColor,
                    btnfg: AppColors.whiteColor,
                    height: height * 0.06,
                    width: width * 0.2,
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
