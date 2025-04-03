import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/guestselection/guestmodal.dart';
import 'package:whodeenii/service/api.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:flutter/material.dart';

class ReservationDoneT extends StatefulWidget {
  final VoidCallback onPressed;
  const ReservationDoneT({super.key, required this.onPressed});

  @override
  State<ReservationDoneT> createState() => _ReservationDoneTState();
}

class _ReservationDoneTState extends State<ReservationDoneT> {
  int selectedIndex = 0;
  List<Guests> guest = [
    Guests(guestname: 'guestname'),
    Guests(guestname: 'guest name'),
    Guests(guestname: 'guestname'),
    Guests(guestname: 'guestname'),
    Guests(guestname: 'guest name'),
    Guests(guestname: 'Guest Name'),
  ];
  List allguest = [];
  bool isLoading = true;
  late String reservationnumber = '000';
  late String arrivaldate = '000';
  late String departuredate = '000';
  late int adults = 0;
  late int children = 0;
  late String roomtype = '000';
  late String roomnumber = '000';

  @override
  void initState() {
    super.initState();
    fetchReservationData();
  }

  Future<void> fetchReservationData() async {
    final resevrationdetails = await Api.completereservationdetails();
    if (resevrationdetails != null) {
      isLoading = false;
      reservationnumber = resevrationdetails['reservationNumber'];
      if (resevrationdetails['arrival'] != null) {
        arrivaldate = resevrationdetails['arrival'].split("T")[0];
      }
      if (resevrationdetails['departure'] != null) {
        departuredate = resevrationdetails['departure'].split("T")[0];
      }
      adults = resevrationdetails['adultCount'];
      children = resevrationdetails['childCount'];
      roomtype = resevrationdetails['roomType'];
      roomnumber = resevrationdetails['roomNumber'];
      if (resevrationdetails['guestList'] != null) {
        allguest = List<Guests>.from(
          resevrationdetails['guestList'].map(
            (guest) => Guests(guestname: guest['guestName']),
          ),
        );
      } else {
        allguest = List.from(guest);
      }

      if (mounted) {
        setState(() {});
      }
      print(resevrationdetails);
    } else {
      setState(() {
        isLoading = true;
      });
    }
  }

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
          isLoading
              ? CircularProgressIndicator()
              : Text(
                "Reservation No. $reservationnumber",
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(
                          arrivaldate,
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(
                          '$adults',
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(
                          roomtype,
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(
                          departuredate,
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(
                          "$children",
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(
                          roomnumber,
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
              child:
                  isLoading
                      ? Row(
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
                      )
                      : Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: width * 0.5,
                        height: height * 0.7,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            padding: EdgeInsets.all(0.0),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allguest.length,
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
                                    vertical: height * 0.058,
                                    horizontal: width * 0.005,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        allguest[index].guestname,
                                        style: TextStyle(
                                          color: AppColors.gray4959,
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
                              );
                            },
                          ),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
