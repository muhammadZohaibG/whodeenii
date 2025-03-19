import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String fairmontLogo;
  final String poweredByLogo;

  const HeaderWidget({
    super.key,
    required this.fairmontLogo,
    required this.poweredByLogo,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isTablet = width > 600;

    return Padding(
      padding: EdgeInsets.only(left: width * 0.016, right: width * 0.016),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            isTablet
                ? [
                  SizedBox(width: width * 0.01),
                  const Spacer(),
                  SizedBox(
                    width: width * 0.3,
                    height: height * 0.2,
                    child: Image.asset(fairmontLogo),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.asset(poweredByLogo, width: width * 0.02),
                      Text(
                        "Powered by",
                        style: TextStyle(fontSize: width * 0.009),
                      ),
                      Text(
                        "Whodeenii",
                        style: TextStyle(
                          fontSize: width * 0.009,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ]
                : [
                  SizedBox(),
                  SizedBox(
                    width: width * 0.3,
                    height: height * 0.11,
                    child: Image.asset(fairmontLogo),
                  ),
                  SizedBox(),
                ],
      ),
    );
  }
}
