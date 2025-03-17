import 'package:emsmeraki/utils/colors.dart';
import 'package:emsmeraki/utils/sizeconf.dart';
import 'package:flutter/material.dart';

class HeaderComponent extends StatelessWidget {
  final String lineLogo;
  final String poweredByLogo;
  final String heading;
  final String contentline;

  const HeaderComponent({
    super.key,
    required this.lineLogo,
    required this.poweredByLogo,
    required this.heading,
    required this.contentline,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(lineLogo, width: width * 0.12),
              Text(
                heading,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: MySize.size15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                contentline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF3D4959),
                  fontSize: width * 0.018,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(poweredByLogo, width: width * 0.05),
              const Text("Powered by"),
              const Text("Whodeenii"),
            ],
          ),
        ],
      ),
    );
  }
}
