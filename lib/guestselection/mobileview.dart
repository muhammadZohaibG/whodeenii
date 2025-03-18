import 'package:whodeenii/guestselection/guestmodal.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:flutter/material.dart';

class GuestSelection extends StatefulWidget {
  const GuestSelection({super.key});

  @override
  State<GuestSelection> createState() => _GuestSelectionState();
}

class _GuestSelectionState extends State<GuestSelection> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Digital Registration",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            regdetails,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size16,
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
                      fontSize: MySize.size16,
                      fontFamily: 'Roboto',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              ListView.builder(
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
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
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
                          const SizedBox(width: 10),
                          Text(
                            guest[index].guestname,
                            style: TextStyle(
                              fontSize: 16,
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
            ],
          ),
        ],
      ),
    );
  }
}
